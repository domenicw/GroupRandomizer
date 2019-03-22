//
//  Group.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Group {
    
    // MARK: - Variables
    
    /// Contains all players in this group
    public var players: [Player]
    
    // MARK: - Intializers
    
    /// Initializes a new Group object
    /// - Parameter players: Array containing all players for this group
    init(players: [Player]) {
        self.players = players
    }
    
}
