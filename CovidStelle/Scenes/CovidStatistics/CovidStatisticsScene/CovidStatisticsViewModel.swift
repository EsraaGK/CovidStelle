//
//  CovidStatisticsViewModel.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift
import UIKit
import CoreLocation

public class CovidStatisticsViewModel: NSObject {
    
    // MARK: - Properties
    private let covidStatisticsRepository: CovidStatisticsRepositoryProtocol
    
    private let _viewState = PublishSubject<ViewState>()
    public var viewState: Observable<ViewState> { return _viewState.asObservable() }
    
    public let statusLabel = PublishSubject<String>()
    public let statusColor = PublishSubject<UIColor>()
    
    public let firstInstructionLabel = PublishSubject<String>()
    public let secondInstructionLabel = PublishSubject<String>()
    
    public let dataViewIsHidden = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    private let locationManger = CLLocationManager()
    // MARK: - Methods
    public init(covidStatisticsRepository: CovidStatisticsRepositoryProtocol) {
        self.covidStatisticsRepository = covidStatisticsRepository
        
        super.init()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    @objc
    public func fetchCovidStatistics() {
        let location = locationManger.location?.coordinate
        covidStatisticsRepository.getCovidStatisticsIn(longitude: location?.longitude ?? 0.0,
                                                       latitude: location?.latitude ?? 0.0)
            .subscribe(onSuccess: { covidStatistics in
                if let newValue = covidStatistics.features?.first?.attributes?.cases7Per100k {
                    
                    let state = CovidStateService().determineCurrentState(using: newValue)
                    self._viewState.onNext(.data(data: state))
                    self.updateStatusLabel(with: state)
                    self.saveLatestCovidRecord(value: newValue)
                    
                }
                self.fireNotificationIfNeeded(with: covidStatistics.features?.first?.attributes?.cases7Per100k)
                
            }, onError: { error in
                self._viewState.onNext(.error(message: error.localizedDescription))
            }).disposed(by: disposeBag)
        
    }
    
    private func fireNotificationIfNeeded(with value: Double?) {
        if let oldValue = self.getLatestCovidRecord(),
           let newValue = value,
           oldValue != newValue {
            let state = CovidStateService().determineCurrentState(using: newValue)
            
            NotificationService.shared.fireNotification(
                state: state.firstInstruction + String(newValue))
            
        }
    }
    public func viewLoaded() {
        if ConnectionCheck.isConnectedToNetwork() {
            _viewState.onNext(.loading)
            fetchCovidStatistics()
        } else {
            _viewState.onNext(.noInternet)
        }
    }
    
    public func scedualeForgroundUpdate() {
        Timer.scheduledTimer(timeInterval: TimeInterval(AppConstInt.tenMinutes.rawValue),
                             target: self,
                             selector: #selector(self.excuteForgroundUpdate),
                             userInfo: nil,
                             repeats: true)
    }
    @objc
    private func excuteForgroundUpdate() {
        if ConnectionCheck.isConnectedToNetwork() {
            fetchCovidStatistics()
        } else {
            return
        }
    }
    
    private func saveLatestCovidRecord(value: Double?) {
        covidStatisticsRepository.saveLatestCovidRecord(value: value)
    }
    
    private func getLatestCovidRecord() -> Double? {
        covidStatisticsRepository.getLatestCovidRecord()
    }
    
    private func saveFirstAppUse(value: Bool?) {
        covidStatisticsRepository.saveFirstAppUse(value: value)
    }
    
    private func getFirstAppUse() -> Bool? {
        covidStatisticsRepository.getFirstAppUse()
    }
    
    private func updateStatusLabel(with state: CovidState) {
        statusColor.onNext(state.color)
        statusLabel.onNext(NSLocalizedString(LocalizationStringKeys.statusMessage.rawValue, comment: "")
        )
        firstInstructionLabel.onNext(state.firstInstruction)
        secondInstructionLabel.onNext(state.secondInstruction)
    }
}

extension CovidStatisticsViewModel: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            viewLoaded()
        case .denied, .notDetermined, .restricted:
            
            if let getFirstAppUse = getFirstAppUse(), getFirstAppUse == false {
                _viewState.onNext(.requestLocationPermission)
            } else {
                saveFirstAppUse(value: false)
                return
            }
            
        @unknown default:
            break
        }
    }
    
}
