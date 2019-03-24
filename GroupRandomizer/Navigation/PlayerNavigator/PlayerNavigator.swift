//
//  PlayerNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerNavigator: Navigator {
    
    // MARK: - Variables
    
    public var delegate: RootNavigatorDelegate?
    
    public var model: RandomizerModel
    
    public var navigationController: UINavigationController
    
    public var childNavigators: [Navigator] = []
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        let playerController = PlayersListViewController(model: model.players)
        self.navigationController = ContinuousNavigationController(rootViewController: playerController)
        self.model = model
        self.model.add(delegate: self)
        
        playerController.delegate = self
    }
    
    public func enterCreatePlayer() {
        let navigator = PlayerCreationNavigator(model: self.model)
        self.childNavigators.append(navigator)
        navigator.navigationController.modalPresentationStyle = .formSheet
        self.navigationController.present(navigator.navigationController, animated: true, completion: nil)
    }
    
    public func showPlayerDetails(_ player: Player) {
        let playerViewController = PlayerDetailsViewController()
        playerViewController.state = .default
        playerViewController.delegate = self
        playerViewController.setup(with: player)
        self.navigationController.pushViewController(playerViewController, animated: true)
    }
    
}

extension PlayerNavigator: RandomizerModelDelegate {
    
    public func groupsDidChange() {}
    
    public func playersDidChange() {
        if let viewController = self.navigationController.topViewController as? PlayersListViewController {
            viewController.model = self.model.players
        }
    }
    
}

extension PlayerNavigator: PlayersListViewControllerDelegate {
    
    public func addPlayer() {
        self.enterCreatePlayer()
    }
    
    public func editNameOfPlayer(_ index: Int) {
        self.showPlayerDetails(self.model.players[index])
    }
    
    public func removePlayer(_ index: Int) {
        self.model.players.remove(at: index)
    }
    
    public func randomize() {
        self.delegate?.randomize()
    }
    
}

extension PlayerNavigator: PlayerDetailsViewControllerDelegate {
    
    public func save(_ player: Player) {
        self.model.players.append(player)
    }
    
    public func cancel() {
        self.navigationController.popViewController(animated: true)
    }
    
}
