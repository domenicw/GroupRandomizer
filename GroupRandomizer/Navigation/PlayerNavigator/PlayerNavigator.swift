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
        /*
        let alert = UIAlertController(title: AlertText.addPlayerNameTitle.localized, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = AlertText.addPlayerNamePlaceholder.localized
        }
        
        let saveAction = UIAlertAction(title: AlertText.genericSaveTitle.localized, style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                let person = Player(name: name)
                self.model.players.append(person)
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: AlertText.genericCancelTitle.localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.navigationController.present(alert, animated: true, completion: nil)
 */
    }
    
    public func editNameOfPlayer(_ index: Int) {
        let alert = UIAlertController(title: AlertText.editPlayerNameTitle.localized, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = AlertText.addPlayerNamePlaceholder.localized
            textField.text = self.model.players[index].name
        }
        
        let saveAction = UIAlertAction(title: AlertText.genericSaveTitle.localized, style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                self.model.players[index].name = name
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: AlertText.genericCancelTitle.localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.navigationController.present(alert, animated: true, completion: nil)
        }
    }
    
    public func removePlayer(_ index: Int) {
        self.model.players.remove(at: index)
    }
    
    public func randomize() {
        self.delegate?.randomize()
    }
    
}
