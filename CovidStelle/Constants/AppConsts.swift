//
//  AppConsts.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/16/20.
//

import UIKit

public enum AppConstString: String {
    case bgTaskId = "com.covidStelle.getCovidStatistics" //BGTask Id
    case latestCovidRecord = "latest_covid_record" //userDefaults key
    
}

public enum LocalizationStringKeys: String {
    case commanInstructions1 = "comman_instructions_1"
    case commanInstructions2 = "comman_instructions_2"
    case commanInstructions3 = "comman_instructions_3"
    case commanInstructions4 = "comman_instructions_4"
    case notificationMessage = "notification_message"
    case greenState1 = "green_state_1"
    case greenState2 = "green_state_2"
    case yellowState1 = "yellow_state_1"
    case yellowState2 = "yellow_state_2"
    case redState1 = "red_state_1"
    case redState2 = "red_state_2"
    case darkState1 = "dark_state_1"
    case darkState2 = "dark_state_2"
    case statusMessage = "status.message"
   //case staySafe = "Stay Safe"
}

public enum ViewState {
    case noInternet
    case error (message: String?)
    case data (data: CovidState)
    case loading
}

public enum CovidState {
    case green
    case yellow
    case red
    case darkRed
    
    var color: UIColor {
        switch self {
        case .green: return .green
        case .yellow: return .yellow
        case .red: return .red
        case .darkRed: return UIColor(red: 102, green: 0, blue: 0, alpha: 1)
        }
        
    }
    
    var firstInstruction: String {
        switch self {
        case .green: return NSLocalizedString("green_state_1", comment: "")
        case .yellow: return NSLocalizedString("yellow_state_1", comment: "")
        case .red: return NSLocalizedString("red_state_1", comment: "")
        case .darkRed: return NSLocalizedString("dark_state_1", comment: "")
        }
    }
    
    var secondInstruction: String {
        switch self {
        case .green: return NSLocalizedString("green_state_2", comment: "")
        case .yellow: return NSLocalizedString("yellow_state_2", comment: "")
        case .red: return NSLocalizedString("red_state_2", comment: "")
        case .darkRed: return NSLocalizedString("dark_state_2", comment: "")
        }
    }
}
