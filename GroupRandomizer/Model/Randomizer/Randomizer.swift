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
    
    /// Randomizes players into groups
    /// - Returns: Array of groups containing random persons
    public static func randomize(model: RandomizerModel) {
        for person in model.players {
            let token = Double.random(in: 0..<100)
            person.randomToken = token
        }
        
        let sorted = model.players.sorted(by: {$0.randomToken < $1.randomToken})
        
        var players: [[Player]] = Array.init(repeating: [], count: model.numberOfGroups)
        
        for (index, player) in sorted.enumerated() {
            players[index % model.numberOfGroups].append(player)
        }
        
        let groups = players.map({Group(players: $0)})
        
        model.groups = groups
    }
}
