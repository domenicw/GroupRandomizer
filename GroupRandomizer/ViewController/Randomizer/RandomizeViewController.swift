//
//  RandomizeViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import UIKit

class RandomizeViewController: UIViewController {
    
    // MARK: - View Variables
    
    /// Randomize button
    public var randomizeButton: UIButton!
    
    // MARK: - Variables
    
    public var delegate: RandomizeViewControllerDelegate?
    
    /// Randomizer
    public let model: RandomizerModel
    
    /// Indicates current active child
    private let activeChild: ActiveChildViewController
    
    // MARK: - Private types
    
    public enum ActiveChildViewController {
        case person
        case group
    }
    
    // MARK: - Inizializers
    
    public init(model: RandomizerModel, activeChild: ActiveChildViewController) {
        self.model = model
        self.activeChild = activeChild
        
        super.init(nibName: nil, bundle: nil)
        
        self.randomizeButton = createRandomButton()
        self.view.addSubview(self.randomizeButton)
        
        if activeChild == .person {
            let personsViewController = self.createPersonListViewController()
            self.display(child: personsViewController)
        } else {
            let groupsViewController = self.createGroupsListViewController()
            self.display(child: groupsViewController)
        }
        
        self.applyRandomButtonConstraints()
        
        self.addBarButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createRandomButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Randomize", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.randomizeGroups), for: .touchUpInside)
        
        return button
    }
    
    private func applyRandomButtonConstraints() {
        NSLayoutConstraint(item: self.randomizeButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    private func createPersonListViewController() -> PersonListTableViewController {
        let view = PersonListTableViewController(model: self.model)
        view.view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func createGroupsListViewController() -> GroupsListTableViewController {
        let view = GroupsListTableViewController(model: self.model)
        view.view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
 
    private func applyChildViewControllerConstraints(viewController: UIViewController, isActive: Bool) {
        NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 0).isActive = isActive
        NSLayoutConstraint(item: viewController.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = isActive
        NSLayoutConstraint(item: viewController.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = isActive
        NSLayoutConstraint(item: viewController.view, attribute: .bottom, relatedBy: .equal, toItem: self.randomizeButton, attribute: .top, multiplier: 1, constant: -10).isActive = isActive
    }
    
    private func createAddItem() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPerson))
        addButton.tintColor = UIColor(named: "lightBlue")
        
        return addButton
    }
    
    private func createNumberOfGroupsItem() -> UIBarButtonItem {
        let numberButton = UIBarButtonItem(title: "Nr.", style: .done, target: self, action: #selector(self.changeNumberOfGroups))
        numberButton.tintColor = UIColor(named: "lightBlue")
        
        return numberButton
    }
    
    private func addBarButtons() {
        var items: [UIBarButtonItem] = []
        
        if self.activeChild == .person {
            items = [createAddItem()]
        } else {
            items = [createNumberOfGroupsItem()]
        }
        
        self.navigationItem.rightBarButtonItems = items
    }
    
    // MARK: - Child controller display
    
    private func display(child: UIViewController) {
        self.addChild(child)
        self.view.addSubview(child.view)
        self.applyChildViewControllerConstraints(viewController: child, isActive: true)
        child.didMove(toParent: self)
    }
    
    // MARK: - View setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        if self.activeChild == .person {
            self.title = "People"
        } else {
            self.title = "Groups"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - View Interaction
    
    @objc public func randomizeGroups() {
        debugPrint("🚨 Randomizing groups")
        
        self.delegate?.randomize()
    }
    
    @objc public func addPerson() {
        debugPrint("🚨 Adding person")
        
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name of person"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                let person = Person(name: name)
                self.model.people.append(person)
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc public func changeNumberOfGroups() {
        debugPrint("🚨 Changeing number of groups")
        
        let alert = UIAlertController(title: "Number of Groups", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "\(self.model.numberOfGroups)"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let numberOfGroups = alert.textFields?[0].text {
                self.model.numberOfGroups = Int(numberOfGroups) ?? 2
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
