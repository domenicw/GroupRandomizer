//
//  AlertText.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum AlertText: String, Localizable {
    
    // MARK: - Text Cases
    
    case genericSaveTitle = "generic_save_title"
    case genericCancelTitle = "generic_cancel_title"
    case nrGroupsTitle = "nr_groups_title"
    case addPlayerNameTitle = "add_player_name_title"
    case addPlayerNamePlaceholder = "add_player_name_placeholder"
    case editPlayerNameTitle = "edit_player_name_title"
    
    // MARK: - Table Name
    
    public var tableName: String {
        return "Alert"
    }
    
}
