//
//  NetworkTargetType.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation
import Moya

enum CovidStatisticsRoute {
    case cases7Per100k (longitude: Double, latitude: Double)
    
}

extension CovidStatisticsRoute: TargetType {
    var baseURL: URL {
        switch self {
        case .cases7Per100k:
            if let baseUrl = URL(
                string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/") {
                return baseUrl
            } else {
                fatalError("couldn't make the baseURL")
            }
        }
    }
    
    var path: String {
        switch self {
        case .cases7Per100k: return "FeatureServer/0/query"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .cases7Per100k:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .cases7Per100k(let longitude, let latitude):
            return .requestParameters(
                parameters: ["returnGeometry": "false",
                             "geometryType": "esriGeometryPoint",
                             "f": "json",
                             "outFields": "cases7_per_100k",
                             "geometry": "{\"x\":\(longitude),\"y\":\(latitude),\"spatialReference\":{\"wkid\":4326}}"],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
