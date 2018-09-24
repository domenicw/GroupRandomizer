//
//  RandomizeText.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum RandomizeText: String, Localizable {
    
    // MARK: - String Cases
    
    case randomizeButtonTitle = "randomize_button_title"
    
    // MARK: - Table
    
    public var tableName: String {
        return "Randomize"
    }
    
}
