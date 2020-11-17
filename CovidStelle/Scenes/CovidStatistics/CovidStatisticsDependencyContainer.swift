//
//  CovidStatisticsDependencyContainer.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation

public class CovidStatisticsDependencyContainer {
    // MARK: - Properties
    private let sharedNetworkManager: NetworkManager
    private let sharedCovidStatisticsRepository: CovidStatisticsRepository
    public let sharedViewModel: CovidStatisticsViewModel
    
    // MARK: - Methods
    public init() {
        sharedNetworkManager = NetworkManager.shared
        sharedCovidStatisticsRepository = CovidStatisticsRepository(networkManger: sharedNetworkManager)
        sharedViewModel = CovidStatisticsViewModel(covidStatisticsRepository: sharedCovidStatisticsRepository)
    }
    
    func getCovidStatisticsView() -> CovidStatisticsViewController {
        CovidStatisticsViewController(viewModelFactory: self)
    }
   
}

extension CovidStatisticsDependencyContainer: ContentViewViewModelFactory {
    public func getContentViewViewModel() -> CovidStatisticsViewModel {
        sharedViewModel
    }
}
