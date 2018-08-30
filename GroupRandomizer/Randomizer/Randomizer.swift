//
//  Randomizer.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Randomizer {
    
    // MARK: - Randomizer
    
    /// Randomizes people into groups
    /// - Returns: Array of groups containing random persons
    public static func randomize(model: RandomizerModel) {
        for person in model.people {
            let token = Double.random(in: 0..<100)
            person.randomToken = token
        }
        
        let sorted = model.people.sorted(by: {$0.randomToken < $1.randomToken})
        
        var persons: [[Person]] = Array.init(repeating: [], count: model.numberOfGroups)
        
        for (index, person) in sorted.enumerated() {
            persons[index % model.numberOfGroups].append(person)
        }
        
        let groups = persons.map({Group(people: $0)})
        
        model.groups = groups
    }
}
