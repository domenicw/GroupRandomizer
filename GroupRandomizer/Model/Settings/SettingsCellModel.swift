//
//  SettingsCellModel.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class SettingsCellModel {
    
    // MARK: - Variables
    
    public var text: String
    
    public var detailText: String?
    
    public var action: SettingsAction
    
    public var cellType: SettingsCellType
    
    // MARK: - Initializers
    
    public init(text: String, detailText: String? = nil, action: SettingsAction, cellType: SettingsCellType = .normal) {
        self.text = text
        self.detailText = detailText
        self.action = action
        self.cellType = cellType
    }
    
}
