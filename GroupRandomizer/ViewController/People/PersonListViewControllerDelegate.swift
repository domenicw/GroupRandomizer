//
//  PersonListViewControllerDelegate.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 22.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public protocol PersonListViewControllerDelegate: RandomizeViewControllerDelegate {
    
    func addPerson()
    
    func editNameOfPerson(_ index: Int)
    
    func removePerson(_ index: Int)
    
}
