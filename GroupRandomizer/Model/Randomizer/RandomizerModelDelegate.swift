//
//  RandomizerModelDelegate.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public protocol RandomizerModelDelegate: class {
    
    func groupsDidChange()
    
    func peopleDidChange()
    
}
