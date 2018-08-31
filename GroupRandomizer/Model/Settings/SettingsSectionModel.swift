//
//  SettingsSectionModel.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class SettingsSectionModel {
    
    // MARK: - Variables
    
    public var headerText: String?
    
    public var footerText: String?
    public var footerTextAlignment: NSTextAlignment
    
    public var cellModels: [SettingsCellModel]
    
    // MARK: - Initializers
    
    public init(headerText: String?, footerText: String?, cellModels: [SettingsCellModel], footerTextAlignment: NSTextAlignment = .left) {
        self.headerText = headerText
        self.footerText = footerText
        self.footerTextAlignment = footerTextAlignment
        self.cellModels = cellModels
    }
    
    public convenience init(headerText: String?, footerText: String?) {
        self.init(headerText: headerText, footerText: footerText, cellModels: [])
    }
    
}
