//
//  SettingsAction.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public enum SettingsAction {
    
    case none
    case tipJar
    
    public func indicator() -> UITableViewCell.AccessoryType {
        switch self {
        case .none:
            return .none
        case .tipJar:
            return .disclosureIndicator
        }
    }
}
