//
//  File.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation

struct Attribute: Codable {

    let cases7Per100k: Double?

    enum CodingKeys: String, CodingKey {
        case cases7Per100k = "cases7_per_100k"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cases7Per100k = try values.decodeIfPresent(Double.self, forKey: .cases7Per100k)
    }
}
