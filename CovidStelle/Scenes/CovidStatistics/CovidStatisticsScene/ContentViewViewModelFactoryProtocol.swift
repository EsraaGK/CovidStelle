//
//  ContentViewViewModelFactoryProtocol.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation

public protocol ContentViewViewModelFactory {
    func getContentViewViewModel() -> CovidStatisticsViewModel
}
