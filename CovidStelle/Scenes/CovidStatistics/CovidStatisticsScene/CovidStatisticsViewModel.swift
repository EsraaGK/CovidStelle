//
//  CovidStatisticsViewModel.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift
import UIKit

public class CovidStatisticsViewModel: ObservableObject {

    // MARK: - Properties
    private let covidStatisticsRepository: CovidStatisticsRepository
    
    private let _viewState = PublishSubject<ViewState>()
    public var viewState: Observable<ViewState> { return _viewState.asObservable() }
    
    public let statusLabel = PublishSubject<String>()
    public let statusColor = PublishSubject<UIColor>()
    
    public let firstInstructionLabel = PublishSubject<String>()
    public let secondInstructionLabel = PublishSubject<String>()
    
    public let dataViewIsHidden = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    public init(covidStatisticsRepository: CovidStatisticsRepository) {
        self.covidStatisticsRepository = covidStatisticsRepository
    }
    
    @objc
    public func fetchCovidStatistics() {
        let location = LocationService.shared.getcurrentLocation()?.coordinate
        covidStatisticsRepository.getCovidStatisticsIn(longitude: location?.longitude ?? 0.0,
                                                       latitude: location?.latitude ?? 0.0)
            .subscribe(onSuccess: { covidStatistics in
                if let newValue = covidStatistics.features?.first?.attributes?.cases7Per100k {
                
                let state = self.defineCurrentState(cases7Per100k: newValue)
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
            let state = self.defineCurrentState(cases7Per100k: newValue)
           
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
        Timer.scheduledTimer(timeInterval: 10 * 60,
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
        UserDefaults.standard.set(value, forKey: AppConstString.latestCovidRecord.rawValue)
    }
    
    private func getLatestCovidRecord() -> Double? {
        UserDefaults.standard.object(forKey: AppConstString.latestCovidRecord.rawValue) as? Double
    }
    
    private func defineCurrentState(cases7Per100k: Double) -> CovidState {
        if 0..<35 ~= cases7Per100k {
            return CovidState.green
            
        } else if 35..<50 ~= cases7Per100k {
            return CovidState.yellow
            
        } else if 50..<100 ~= cases7Per100k {
            return CovidState.red
            
        } else {
            return CovidState.darkRed
        }
        
    }
    
    private func updateStatusLabel(with state: CovidState) {
        statusColor.onNext(state.color)
        statusLabel.onNext(NSLocalizedString(LocalizationStringKeys.statusMessage.rawValue, comment: "")
            )
        firstInstructionLabel.onNext(state.firstInstruction)
        secondInstructionLabel.onNext(state.secondInstruction)
    }
}
