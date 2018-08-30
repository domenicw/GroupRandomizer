//
//  RootNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class RootNavigator {
    
    // MARK: - Variables
    
    public var model: RandomizerModel
    
    public var tabBarController: UITabBarController
    
    public var childCoordinators: [Navigator]
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        let tabBar = UITabBarController()
        self.tabBarController = tabBar
        self.childCoordinators = []
        self.model = model
        
        self.createGroupsList()
    }
    
    // MARK: - Child Creation
    
    func createGroupsList() {
        let groupsNavigator = GroupsNavigator(model: self.model)
        groupsNavigator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        self.childCoordinators.append(groupsNavigator)
    }
    
    func createPersonsList() {
        
    }
    
    
}
