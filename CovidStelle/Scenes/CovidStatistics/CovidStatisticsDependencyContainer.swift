//
//  CovidStatisticsDependencyContainer.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/12/20.
//

import Foundation

public class CovidStatisticsDependencyContainer {
    // MARK: - Properties
    private let networkManager: NetworkManager
    private let covidStatisticsRepository: CovidStatisticsRepository
    private let userDefaultsManger: UserDefaultsManager
    public let sharedViewModel: CovidStatisticsViewModel
    
    // MARK: - Methods
    public init() {
        networkManager = NetworkManager.shared
        userDefaultsManger = UserDefaultsManager()
        covidStatisticsRepository = CovidStatisticsRepository(networkManger: networkManager,
                                                              userDefaultsManger: userDefaultsManger)
        sharedViewModel = CovidStatisticsViewModel(covidStatisticsRepository: covidStatisticsRepository)
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
