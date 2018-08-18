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
    
    private static let defaults = UserDefaults.standard
    
    // MARK: - Storage Names
    
    fileprivate enum Name: String {
        case people
        case numberOfGroups
    }
    
    // MARK: - Saving
    
    public static func save(numberOfGroups: Int) {
        self.defaults.set(numberOfGroups, forKey: Name.numberOfGroups.rawValue)
    }
    
    public static func save(names: [String]) {
        self.defaults.set(names, forKey: Name.people.rawValue)
    }
    
    // MARK: - Retrieving
    
    public static func retrieveNumberOfGroups() -> Int {
        return self.defaults.integer(forKey: Name.numberOfGroups.rawValue)
    }
    
    public static func retrieveNames() -> [String] {
        let people = defaults.object(forKey: Name.people.rawValue) as? [String] ?? []
        return people
    }
}
