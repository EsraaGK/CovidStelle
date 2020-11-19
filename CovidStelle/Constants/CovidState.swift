//
//  CovidState.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/18/20.
//

import UIKit

public enum CovidState: CaseIterable {
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
    
    var statusRange: Range<Double> {
        switch self {
        case .green: return 0..<35
        case .yellow: return 35..<50
        case .red: return 50..<100
        case .darkRed: return 100..<Double.infinity
        }
    }
}
