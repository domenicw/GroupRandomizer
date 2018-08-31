//
//  SettingsNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class SettingsNavigator: Navigator {
    
    // MARK: - Variables
    
    public var navigationController: UINavigationController
    
    public var model: SettingsModel
    
    // MARK: - Initializers
    
    public init() {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        
        self.model = SettingsModel.create()
        
        let settingsViewController = SettingsViewController(model: self.model)
        navigationController.pushViewController(settingsViewController, animated: false)
    }
    
}
