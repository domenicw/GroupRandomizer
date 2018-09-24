//
//  Localizable.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public protocol Localizable {
    
    var localized: String { get }
    
    var tableName: String { get }
    
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    public var localized: String {
        return NSLocalizedString(self.rawValue, tableName: self.tableName, bundle: Bundle.main, value: "", comment: "")
    }
    
}
