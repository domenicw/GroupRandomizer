//
//  PeopleText.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum PeopleText: String, Localizable {
    
    // MARK: - Text Cases
    
    case viewTitle = "view_title"
    
    // MARK: - Table Name
    
    public var tableName: String {
        return "People"
    }
    
}
