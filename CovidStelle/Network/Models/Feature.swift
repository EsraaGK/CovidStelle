//
//  File.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation

struct Feature: Codable {
    
    let attributes: Attribute?
    
    enum CodingKeys: String, CodingKey {
        case attributes
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attributes = try values.decodeIfPresent(Attribute.self, forKey: .attributes)
    }
}
