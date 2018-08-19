//
//  Storage.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 18.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Storage {
    
    // MARK: - Variables
    
    /// UserDefaults instance
    /// Access this to save and retrieve stored values
    private static let defaults = UserDefaults.standard
    
    // MARK: - Storage Name Keys
    
    /// Key strings for saved values
    fileprivate enum Name: String {
        case people
        case numberOfGroups
    }
    
    // MARK: - Saving
    
    /// Saves number of groups to userDefaults
    /// - Parameter numberOfGroups: number of groups to store
    public static func save(numberOfGroups: Int) {
        self.defaults.set(numberOfGroups, forKey: Name.numberOfGroups.rawValue)
    }
    
    /// Saves all persons names to userDefaults
    /// - Parameter names: Array of all the names of all the people to store
    public static func save(names: [String]) {
        self.defaults.set(names, forKey: Name.people.rawValue)
    }
    
    // MARK: - Retrieving
    
    /// Retrieves number of groups to divide the people up into
    /// - Returns: number of groups to divide people up into
    public static func retrieveNumberOfGroups() -> Int {
        return self.defaults.integer(forKey: Name.numberOfGroups.rawValue)
    }
    
    /// Retrieves all the names of all the people
    /// - Returns: An Array containing all the names of all the people
    public static func retrieveNames() -> [String] {
        let people = defaults.object(forKey: Name.people.rawValue) as? [String] ?? []
        return people
    }
}
