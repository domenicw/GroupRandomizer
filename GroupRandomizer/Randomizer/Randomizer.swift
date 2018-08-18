//
//  Randomizer.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Randomizer {
    
    // MARK: - Variables
    
    /// Number of groups to split people into
    public var numberOfGroups: Int
    
    /// Array containing all the people to split into the groups
    public var people: [Person]
    
    // MARK: - Initializers
    
    /// Creates a new Randomizer object
    /// - Parameters:
    ///     - numberOfGroups: Number of groups to split people into
    ///     - people: People to split up
    public init(numberOfGroups: Int, people: [Person]) {
        self.numberOfGroups = numberOfGroups
        self.people = people
    }
    
    /// Creates a new Randomizer object
    /// - Parameter people: People to split up
    public convenience init(people: [Person]) {
        self.init(numberOfGroups: 2, people: people)
    }
    
    // MARK: - Randomizer
    
    /// Randomizes people into groups
    /// - Returns: Array of groups containing random persons
    public func randomize() -> [Group] {
        for person in self.people {
            let token = Double.random(in: 0..<100)
            person.randomToken = token
        }
        
        let sorted = people.sorted(by: {$0.randomToken < $1.randomToken})
        
        var persons: [[Person]] = Array.init(repeating: [], count: self.numberOfGroups)
        
        for (index, person) in sorted.enumerated() {
            persons[index % self.numberOfGroups].append(person)
        }
        
        let groups = persons.map({Group(people: $0)})
        
        return groups
    }
}
