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
    
    public var text: String?
    
    public var action: SettingsAction
    
    // MARK: - Initializers
    
    public init(text: String?, action: SettingsAction) {
        self.text = text
        self.action = action
    }
    
}
