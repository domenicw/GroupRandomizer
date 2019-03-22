//
//  RootText.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum RootText: String, Localizable {
    
    // MARK: - Text Cases
    
    case groupTabTitle = "group_tap_title"
    case playersTabTitle = "players_tab_title"
    case settingsTabTitle = "settings_tab_title"
    
    // MARK: - Table Name
    
    public var tableName: String {
        return "Root"
    }
    
}
