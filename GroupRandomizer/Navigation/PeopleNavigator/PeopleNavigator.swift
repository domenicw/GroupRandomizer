//
//  PeopleNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PeopleNavigator: Navigator {
    
    // MARK: - Variables
    
    public var delegate: RootNavigatorDelegate?
    
    public var model: RandomizerModel
    
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        let peopleController = PersonListViewController(model: model.people)
        self.navigationController = UINavigationController(rootViewController: peopleController)
        self.model = model
        self.model.add(delegate: self)
        
        peopleController.delegate = self
    }
    
}

extension PeopleNavigator: RandomizerModelDelegate {
    
    public func groupsDidChange() {}
    
    public func peopleDidChange() {
        if let viewController = self.navigationController.topViewController as? PersonListViewController {
            viewController.model = self.model.people
        }
    }
    
}

extension PeopleNavigator: PersonListViewControllerDelegate {
    
    public func addPerson() {
        let alert = UIAlertController(title: AlertText.addPersonNameTitle.localized, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = AlertText.addPersonNamePlaceholder.localized
        }
        
        let saveAction = UIAlertAction(title: AlertText.genericSaveTitle.localized, style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                let person = Person(name: name)
                self.model.people.append(person)
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: AlertText.genericCancelTitle.localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.navigationController.present(alert, animated: true, completion: nil)
    }
    
    public func editNameOfPerson(_ index: Int) {
        let alert = UIAlertController(title: AlertText.editPersonNameTitle.localized, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = AlertText.addPersonNamePlaceholder.localized
            textField.text = self.model.people[index].name
        }
        
        let saveAction = UIAlertAction(title: AlertText.genericSaveTitle.localized, style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                self.model.people[index].name = name
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: AlertText.genericCancelTitle.localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.navigationController.present(alert, animated: true, completion: nil)
        }
    }
    
    public func removePerson(_ index: Int) {
        self.model.people.remove(at: index)
    }
    
    public func randomize() {
        self.delegate?.randomize()
    }
    
}
