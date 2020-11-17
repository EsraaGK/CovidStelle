//
//  NetworkManger.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import Moya

class NetworkManager {
    // Mark :- properties
    static let shared = NetworkManager()
    let provider: MoyaProvider<MultiTarget>
    
    private init() {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: loggerConfig)])
    }
}
