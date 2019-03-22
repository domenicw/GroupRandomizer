//
//  GroupsNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class GroupsNavigator: Navigator {
    
    // MARK: - Variables
    
    public var delegate: RootNavigatorDelegate?
    
    public var model: RandomizerModel
    
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        let groupsController = GroupsListViewController(model: model.groups)
        self.navigationController = UINavigationController(rootViewController: groupsController)
        self.model = model
        self.model.add(delegate: self)
        
        groupsController.delegate = self
    }
}

extension GroupsNavigator: RandomizerModelDelegate {
    
    public func groupsDidChange() {
        if let viewController = self.navigationController.topViewController as? GroupsListViewController {
            viewController.model = self.model.groups
        }
    }
    
    public func playersDidChange() {}
    
}

extension GroupsNavigator: GroupsListViewControllerDelegate {
    
    public func randomize() {
        self.delegate?.randomize()
    }
    
    public func changeNumberOfGroups() {
        let alert = UIAlertController(title: AlertText.nrGroupsTitle.localized, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "\(self.model.numberOfGroups)"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        let saveAction = UIAlertAction(title: AlertText.genericSaveTitle.localized, style: .default) { (action) in
            if let numberOfGroups = alert.textFields?[0].text {
                self.model.numberOfGroups = Int(numberOfGroups) ?? 2
                self.randomize()
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: AlertText.genericCancelTitle.localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.navigationController.present(alert, animated: true, completion: nil)
    }
    
}
