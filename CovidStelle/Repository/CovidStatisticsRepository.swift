//
//  CovidStatisticsReposatory.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift

public class CovidStatisticsRepository: CovidStatisticsRepositoryProtocol {
    // MARK: - Properties 
    let networkManger: NetworkMangerProtocol
    let userDefaultsManger: UserDefaultsManagerProtocol
    
    // MARK: - Methods
    init(networkManger: NetworkMangerProtocol, userDefaultsManger: UserDefaultsManagerProtocol) {
        self.networkManger = networkManger
        self.userDefaultsManger = userDefaultsManger
    }
}

extension CovidStatisticsRepository {// NetworkMangerProtocol 
    public func getCovidStatisticsIn(longitude: Double, latitude: Double) -> Single<CovidStatistics> {
        networkManger.getCovidStatisticsIn(longitude: longitude, latitude: latitude)
    }
}

extension CovidStatisticsRepository {//UserDefaultsManagerProtocol
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
