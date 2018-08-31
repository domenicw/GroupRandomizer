//
//  SettingsCellType.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public enum SettingsCellType {
    case normal
    case tipJar
    
    public func reuseIdentifier() -> String {
        switch self {
        case .normal:
            return "cell"
        case .tipJar:
            return "tipCell"
        }
    }
    
    public func style() -> UITableViewCell.CellStyle {
        switch self {
        case .normal:
            return .default
        case .tipJar:
            return .value1
        }
    }
}
