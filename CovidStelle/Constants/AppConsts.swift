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
    case firstAppUse = "first_app_use" //userDefaults key
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
    case locationPermissions = "location_permissions"
    case locationPermissionsMessage = "location_permissions_message"
    case settings = "settings"
    case cancel = "cancel"
}

enum AppConstInt: Int {
    case tenMinutes = 600
}
