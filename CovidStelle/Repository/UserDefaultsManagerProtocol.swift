//
//  UserDefaultsManagerProtocol.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/18/20.
//

import Foundation

public protocol UserDefaultsManagerProtocol {
    func saveLatestCovidRecord(value: Double?)
    func getLatestCovidRecord() -> Double?
    func saveFirstAppUse(value: Bool?)
    func getFirstAppUse() -> Bool?
}
