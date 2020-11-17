//
//  LocationService.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/16/20.
//

import CoreLocation
import UIKit

public class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    private let locationManger = CLLocationManager()
    
    public override init() {
        super.init()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
    }
    
    func getcurrentLocation() -> CLLocation? {
        locationManger.location
    }
    
    func requestAuthorization() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied, .notDetermined, .restricted:
            requestAuthorization()
        @unknown default:
            break
        }
    }
}
