//
//  PlayersListViewControllerDelegate.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 22.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public protocol PlayersListViewControllerDelegate: RandomizeViewControllerDelegate {
    
    func addPlayer()
    
    func editNameOfPlayer(_ index: Int)
    
    func removePlayer(_ index: Int)
    
}
