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
    
    /// Contains all people in this group
    public var people: [Person]
    
    // MARK: - Intializers
    
    /// Initializes a new Group object
    /// - Parameter persons: Array containing all people for this group
    init(people: [Person]) {
        self.people = people
    }
    
}
