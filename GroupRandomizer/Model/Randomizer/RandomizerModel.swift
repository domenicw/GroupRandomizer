//
//  RandomizerModel.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class RandomizerModel {
    
    // MARK: - Variables
    
    private var delegates: [RandomizerModelDelegate?]
    
    public var numberOfGroups: Int {
        didSet {
            if numberOfGroups == 0 {
                numberOfGroups = 2
            }
        }
    }
    
    public var people: [Person] {
        didSet {
            self.delegates.forEach({ $0?.peopleDidChange() })
        }
    }
    
    public var groups: [Group] {
        didSet {
            self.delegates.forEach({ $0?.groupsDidChange() })
        }
    }
    
    // MARK: - Initializers
    
    public init(numberOfGroups: Int, people: [Person], groups: [Group]) {
        self.numberOfGroups = numberOfGroups
        self.people = people
        self.groups = groups
        self.delegates = []
    }
    
    public convenience init() {
        self.init(numberOfGroups: 2, people: [], groups: [])
        self.retrieve()
    }
    
    // MARK: - Persistant Storage
    
    /// Checks if people is empty
    ///- Returns: True is people is empty
    public func peopleIsEmpty() -> Bool {
        return self.people.isEmpty
    }
    
    /// Saves names of people and numberOfGroups to UserDefaults
    public func save() {
        let names = self.people.map({$0.name})
        Storage.save(names: names)
        Storage.save(numberOfGroups: self.numberOfGroups)
    }
    
    /// Retrieves names of people and numberOfGroups from UserDefaults
    public func retrieve() {
        let names = Storage.retrieveNames()
        self.people = names.map({Person(name: $0)})
        self.numberOfGroups = Storage.retrieveNumberOfGroups()
        
        if !self.peopleIsEmpty() {
            Randomizer.randomize(model: self)
        }
    }
    
    // MARK: - Delegation
    
    public func add(delegate: RandomizerModelDelegate) {
        self.delegates.append(delegate)
    }
    
    public func remove(delegate: RandomizerModelDelegate) {
        self.delegates = self.delegates.filter({ $0 !== delegate })
    }
    
}
