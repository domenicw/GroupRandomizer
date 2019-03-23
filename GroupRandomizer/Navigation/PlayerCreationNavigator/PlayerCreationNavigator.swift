//
//  PlayerCreationNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerCreationNavigator: Navigator {
    
    // MARK: - Variables
    
    public var navigationController: UINavigationController
    
    public var childNavigators: [Navigator] = []
    
    public var model: RandomizerModel
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        self.model = model
        let playerCreationController = PlayerCreationViewController()
        self.navigationController = ContinuousNavigationController(rootViewController: playerCreationController)
        
        playerCreationController.delegate = self
    }
    
    public func dismissNavigator() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
}

extension PlayerCreationNavigator: PlayerCreationViewControllerDelegate {
    
    public func addPlayer(with name: String) {
        let player = Player(name: name)
        self.model.players.append(player)
        self.dismissNavigator()
    }
    
    public func cancelCreation() {
        self.dismissNavigator()
    }
    
}
