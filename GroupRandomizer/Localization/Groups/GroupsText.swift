//
//  GroupsText.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum GroupsText: String, Localizable {
    
    // MARK: - String Cases
    
    case viewTitle = "view_title"
    case sectionGroupTitle = "section_group_title"
    case numberButtonTitle = "number_button_title"
    
    // MARK: - Table
    
    public var tableName: String {
        return "Groups"
    }
    
}
