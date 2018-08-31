//
//  Person.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Person {
    
    // MARK: - Variable
    
    /// Name of person
    public var name: String
    
    /// Random double value needed for sorting into groups
    public var randomToken: Double
    
    // MARK: - Initializers
    
    /// Initializers a new Person
    /// - Parameter name: Name of person
    /// - Note: Sets randomToken to 0
    public convenience init(name: String) {
        self.init(name: name, randomToken: 0)
    }
    
    /// Initializes a new Person
    /// - Parameters:
    ///     - name: Name of person
    ///     - randomToken: Random double value for sorting
    public init(name: String, randomToken: Double) {
        self.name = name
        self.randomToken = randomToken
    }
    
}
