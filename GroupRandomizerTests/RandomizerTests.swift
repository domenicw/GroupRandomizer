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
    
    var people: [Person] = []

    override func setUp() {
        for index in 0..<4 {
            let person = Person(name: String(describing: index))
            people.append(person)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomizer() {
        let model = RandomizerModel(numberOfGroups: self.numberOfGroups, people: self.people, groups: [])
        
        Randomizer.randomize(model: model)
        
        print(groups: model.groups)
        
        checkRandomToken(groups: model.groups)
        checkNumberOfGroups(groups: model.groups)
        checkPeopleDistortion(groups: model.groups)
    }
    
    func checkRandomToken(groups: [Group]) {
        for group in groups {
            for person in group.people {
                XCTAssertFalse(person.randomToken == 0)
            }
        }
    }
    
    func checkNumberOfGroups(groups: [Group]) {
        XCTAssertTrue(self.numberOfGroups == groups.count)
    }
    
    func checkPeopleDistortion(groups: [Group]) {
        XCTAssertFalse(groups[0].people[0].name == people[0].name, "\(groups[0].people[0].name) == \(people[0].name)")
    }
    
    func print(groups: [Group]) {
        for group in groups {
            Swift.print("----------")
            for person in group.people {
                Swift.print(person.name)
            }
        }
    }
    
    func test0Groups() {
        let model = RandomizerModel(numberOfGroups: 2, people: [], groups: [])
        XCTAssert(model.numberOfGroups == 2)
        model.numberOfGroups = 0
        XCTAssert(model.numberOfGroups != 0)
    }

}
