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
    
    public var players: [Player] {
        didSet {
            self.delegates.forEach({ $0?.playersDidChange() })
        }
    }
    
    public var groups: [Group] {
        didSet {
            self.delegates.forEach({ $0?.groupsDidChange() })
        }
    }
    
    // MARK: - Initializers
    
    public init(numberOfGroups: Int, players: [Player], groups: [Group]) {
        self.numberOfGroups = numberOfGroups
        self.players = players
        self.groups = groups
        self.delegates = []
    }
    
    public convenience init() {
        self.init(numberOfGroups: 2, players: [], groups: [])
        self.retrieve()
    }
    
    // MARK: - Persistant Storage
    
    /// Checks if players is empty
    ///- Returns: True is players is empty
    public func playersIsEmpty() -> Bool {
        return self.players.isEmpty
    }
    
    /// Saves names of players and numberOfGroups to UserDefaults
    public func save() {
        let names = self.players.map({$0.name})
        Storage.save(names: names)
        Storage.save(numberOfGroups: self.numberOfGroups)
    }
    
    /// Retrieves names of players and numberOfGroups from UserDefaults
    public func retrieve() {
        let names = Storage.retrieveNames()
        self.players = names.map({Player(name: $0)})
        self.numberOfGroups = Storage.retrieveNumberOfGroups()
        
        if !self.playersIsEmpty() {
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
