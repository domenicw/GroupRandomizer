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
    
    private var skRating = SKRating()
    
    // MARK: - Types
    
    /// Tabs of tabBarController
    private enum Tabs: Int {
        case groups
        case people
        case settings
    }
    
    // MARK: - Initializers
    
    public init(window: UIWindow, model: RandomizerModel) {
        let tabBar = UITabBarController()
        self.tabBarController = tabBar
        self.childCoordinators = []
        self.model = model
        
        window.rootViewController = self.tabBarController
        
        self.setUpTabs()
    }
    
    // MARK: - Tab Bar Setup
    
    /// Sets up all tabs for tab bar controller
    private func setUpTabs() {
        self.createGroupsList()
        self.createPeopleList()
        self.createSettings()
        
        let navControllers = self.childCoordinators.map({$0.navigationController})
        self.tabBarController.viewControllers = navControllers
        self.tabBarController.tabBar.tintColor = .lightBlue
        
        if self.model.peopleIsEmpty() {
            self.tabBarController.selectedIndex = Tabs.people.rawValue
        } else {
            self.tabBarController.selectedIndex = Tabs.groups.rawValue
        }
    }
    
    // MARK: - Child Creation
    
    /// Creates groups list navigator
    func createGroupsList() {
        let groupsNavigator = GroupsNavigator(model: self.model)
        groupsNavigator.delegate = self
        groupsNavigator.navigationController.tabBarItem = UITabBarItem(title: RootText.groupTabTitle.localized, image: UIImage(named: "group"), tag: Tabs.groups.rawValue)
        self.childCoordinators.append(groupsNavigator)
    }
    
    /// Creates people list navigator
    func createPeopleList() {
        let peopleNavigator = PeopleNavigator(model: self.model)
        peopleNavigator.delegate = self
        peopleNavigator.navigationController.tabBarItem = UITabBarItem(title: RootText.peopleTabTitle.localized, image: UIImage(named: "people"), tag: Tabs.people.rawValue)
        self.childCoordinators.append(peopleNavigator)
    }
    
    /// Creates settings navigator
    func createSettings() {
        let settingsNavigator = SettingsNavigator()
        settingsNavigator.navigationController.tabBarItem = UITabBarItem(title: RootText.settingsTabTitle.localized, image: UIImage(named: "settings"), tag: Tabs.settings.rawValue)
        self.childCoordinators.append(settingsNavigator)
    }
    
}

// MARK: - RootNavigatorDelegate extension

extension RootNavigator: RootNavigatorDelegate {
    
    public func randomize() {
        Randomizer.randomize(model: self.model)
        self.tabBarController.selectedIndex = Tabs.groups.rawValue
        self.skRating.rate()
    }
    
}
