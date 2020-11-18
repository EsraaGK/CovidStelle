//
//  UserDefaultsManager.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/18/20.
//

import Foundation

public class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    public func saveLatestCovidRecord(value: Double?) {
        UserDefaults.standard.set(value, forKey: AppConstString.latestCovidRecord.rawValue)
    }
    
    public func getLatestCovidRecord() -> Double? {
        UserDefaults.standard.object(forKey: AppConstString.latestCovidRecord.rawValue) as? Double
    }
    
    public func saveFirstAppUse(value: Bool?) {
        UserDefaults.standard.set(value, forKey: AppConstString.firstAppUse.rawValue)
    }
    
    public func getFirstAppUse() -> Bool? {
        UserDefaults.standard.object(forKey: AppConstString.firstAppUse.rawValue) as? Bool
    }
}
