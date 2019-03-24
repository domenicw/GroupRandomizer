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
        let playerCreationController = PlayerDetailsViewController()
        playerCreationController.state = .newPlayer
        self.navigationController = ContinuousNavigationController(rootViewController: playerCreationController)
        
        playerCreationController.delegate = self
    }
    
    public func dismissNavigator() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
}

extension PlayerCreationNavigator: PlayerDetailsViewControllerDelegate {
    
    public func save(_ player: Player) {
        self.model.players.append(player)
        self.dismissNavigator()
    }
    
    public func cancel() {
        self.dismissNavigator()
    }
    
}
