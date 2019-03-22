//
//  GroupRandomizerTests.swift
//  GroupRandomizerTests
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import XCTest
@testable import GroupRandomizer

class RandomizerTests: XCTestCase {
    
    var numberOfGroups: Int = 3
    var numberOfPlayers: Int = 40
    
    var players: [Player] = []

    override func setUp() {
        for index in 0..<self.numberOfPlayers {
            let player = Player(name: String(describing: index))
            players.append(player)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomizer() {
        let model = RandomizerModel(numberOfGroups: self.numberOfGroups, players: self.players, groups: [])
        
        Randomizer.randomize(model: model)
        
        print(groups: model.groups)
        
        checkRandomToken(groups: model.groups)
        checkNumberOfGroups(groups: model.groups)
        checkPlayerDistortion(groups: model.groups)
        checkPlayerCount(groups: model.groups)
    }
    
    func checkRandomToken(groups: [Group]) {
        for group in groups {
            for player in group.players {
                XCTAssertFalse(player.randomToken == 0)
            }
        }
    }
    
    func checkNumberOfGroups(groups: [Group]) {
        XCTAssertEqual(self.numberOfGroups, groups.count)
    }
    
    func checkPlayerDistortion(groups: [Group]) {
        XCTAssertFalse(groups[0].players[0].name == players[0].name, "\(groups[0].players[0].name) == \(players[0].name)")
    }
    
    func checkPlayerCount(groups: [Group]) {
        let numberOfPlayers = groups.reduce(0, {$0 + $1.players.count})
        XCTAssertEqual(numberOfPlayers, self.numberOfPlayers)
    }
    
    func print(groups: [Group]) {
        for group in groups {
            Swift.print("----------")
            for player in group.players {
                Swift.print(player.name)
            }
        }
    }
    
    func testZeroGroups() {
        let model = RandomizerModel(numberOfGroups: 2, players: [], groups: [])
        XCTAssert(model.numberOfGroups == 2)
        model.numberOfGroups = 0
        XCTAssert(model.numberOfGroups != 0)
    }

}
