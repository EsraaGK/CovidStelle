//
//  HomeNetworkProtocol.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift

protocol CovidStatisticsProtocol: class {
   func getCovidStatisticsIn(longitude: Double, latitude: Double) -> Single<CovidStatistics>
}
