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
    
    public init(window: UIWindow, model: RandomizerModel) {
        let tabBar = UITabBarController()
        self.tabBarController = tabBar
        self.childCoordinators = []
        self.model = model
        
        window.rootViewController = self.tabBarController
        
        self.createGroupsList()
        self.createPeopleList()
        self.createSettings()
        
        let navControllers = self.childCoordinators.map({$0.navigationController})
        self.tabBarController.viewControllers = navControllers
        self.tabBarController.selectedIndex = 0
    }
    
    // MARK: - Child Creation
    
    func createGroupsList() {
        let groupsNavigator = GroupsNavigator(model: self.model)
        groupsNavigator.delegate = self
        groupsNavigator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        self.childCoordinators.append(groupsNavigator)
    }
    
    func createPeopleList() {
        let peopleNavigator = PeopleNavigator(model: self.model)
        peopleNavigator.delegate = self
        peopleNavigator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        self.childCoordinators.append(peopleNavigator)
    }
    
    func createSettings() {
        let settingsNavigator = SettingsNavigator()
        settingsNavigator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        self.childCoordinators.append(settingsNavigator)
    }
    
}

extension RootNavigator: RootNavigatorDelegate {
    
    public func randomize() {
        Randomizer.randomize(model: self.model)
        self.tabBarController.selectedIndex = 0
    }
    
}
