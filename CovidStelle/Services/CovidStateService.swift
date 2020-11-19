//
//  File.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/18/20.
//

import Foundation

public class CovidStateService {

    public func determineCurrentState(using value: Double ) -> CovidState {
        for temp in CovidState.allCases where temp.statusRange ~= value {
            return temp
        }
        return .darkRed
    }
}
