//
//  AppManger.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/17/20.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    private let dependecncyContainer = CovidStatisticsDependencyContainer()
     
     func getContentView() -> CovidStatisticsViewController {
         dependecncyContainer.getCovidStatisticsView()
     }
     
     func getContentViewViewModel() -> CovidStatisticsViewModel {
         dependecncyContainer.getContentViewViewModel()
     }
   
}
