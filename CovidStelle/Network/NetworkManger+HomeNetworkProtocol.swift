//
//  NetworkManger+HomeNetworkProtocol.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import RxSwift
import RxMoya
import Moya

extension NetworkManager: CovidStatisticsProtocol {
    func getCovidStatisticsIn(longitude: Double, latitude: Double) -> Single<CovidStatistics> {
        return provider.rx.request(MultiTarget(CovidStatisticsRoute.cases7Per100k(longitude: longitude,
                                                                                  latitude: latitude)))
            .map(CovidStatistics.self)
    }
}
