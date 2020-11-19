//
//  ViewState.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/18/20.
//

import Foundation

public enum ViewState {
    case noInternet
    case error (message: String?)
    case data (data: CovidState)
    case loading
    case requestLocationPermission
}
