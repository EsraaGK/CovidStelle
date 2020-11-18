//
//  HomeNetworkProtocol.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift

public protocol NetworkMangerProtocol: class {
   func getCovidStatisticsIn(longitude: Double, latitude: Double) -> Single<CovidStatistics>
}
