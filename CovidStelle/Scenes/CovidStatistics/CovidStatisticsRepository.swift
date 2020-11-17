//
//  CovidStatisticsReposatory.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift

public class CovidStatisticsRepository: CovidStatisticsProtocol {
    // MARK: - Properties 
    let networkManger: CovidStatisticsProtocol
    
    // MARK: - Methods
    init(networkManger: CovidStatisticsProtocol) {
        self.networkManger = networkManger
    }
    
    func getCovidStatisticsIn(longitude: Double, latitude: Double) -> Single<CovidStatistics> {
        networkManger.getCovidStatisticsIn(longitude: longitude, latitude: latitude)
    }
}
