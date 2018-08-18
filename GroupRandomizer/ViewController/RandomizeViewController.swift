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
    
    /// Groups button
    public var groupsButton: UIButton!
    
    /// Persons button
    public var personsButton: UIButton!
    
    /// Persons view controller
    public var personsViewController: PersonListTableViewController!
    
    /// Groups view controller
    public var groupsViewController: GroupsListTableViewController!
    
    // MARK: - Variables
    
    /// Randomizer
    public let randomizer: Randomizer
    
    /// Indicates current active child
    private var activeChild: ActiveChildViewController = .person
    
    // MARK: - Private types
    
    fileprivate enum ActiveChildViewController {
        case person
        case group
    }
    
    // MARK: - Inizializers
    
    public init(randomizer: Randomizer) {
        self.randomizer = randomizer
        
        super.init(nibName: nil, bundle: nil)
        self.randomizeButton = createRandomButton()
        self.view.addSubview(self.randomizeButton)
        
        self.groupsButton = self.createGroupsButton()
        self.view.addSubview(self.groupsButton)
        
        self.personsButton = self.createPersonsButton()
        self.view.addSubview(self.personsButton)
        
        self.personsViewController = self.createPersonListViewController()
        self.groupsViewController = self.createGroupsListViewController()
        
        self.applyRandomButtonConstraints()
        self.applyPersonsButtonConstraints()
        self.applyGroupsButtonConstraints()
        self.display(child: self.personsViewController)
        
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
    
    private func createGroupsButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Groups", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.showGroups), for: .touchUpInside)
        
        return button
    }
    
    private func applyGroupsButtonConstraints() {
        NSLayoutConstraint(item: self.groupsButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: self.groupsButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.groupsButton, attribute: .trailing, relatedBy: .equal, toItem: self.personsButton, attribute: .leading, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: self.groupsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    private func createPersonsButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Persons", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.showPersons), for: .touchUpInside)
        
        return button
    }
    
    private func applyPersonsButtonConstraints() {
        NSLayoutConstraint(item: self.personsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        NSLayoutConstraint(item: self.personsButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: self.personsButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.personsButton, attribute: .width, relatedBy: .equal, toItem: self.groupsButton, attribute: .width, multiplier: 1, constant: 0).isActive = true
    }
    
    private func createPersonListViewController() -> PersonListTableViewController {
        let view = PersonListTableViewController(randomizer: self.randomizer)
        view.view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func createGroupsListViewController() -> GroupsListTableViewController {
        let view = GroupsListTableViewController(groups: [])
        view.view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
 
    private func applyChildViewControllerConstraints(viewController: UIViewController, isActive: Bool) {
        NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: self.personsButton, attribute: .bottom, multiplier: 1, constant: 10).isActive = isActive
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
        let addButton = createAddItem()
        let numberButton = createNumberOfGroupsItem()
        
        self.navigationItem.rightBarButtonItems = [addButton, numberButton]
    }
    
    // MARK: - Child view display
    
    private func display(child: UIViewController) {
        self.addChild(child)
        self.view.addSubview(child.view)
        self.applyChildViewControllerConstraints(viewController: child, isActive: true)
        child.didMove(toParent: self)
    }
    
    private func hide(child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        self.applyChildViewControllerConstraints(viewController: child, isActive: false)
        child.removeFromParent()
    }
    
    private func display(child: ActiveChildViewController) {
        guard child != self.activeChild else {
            return
        }
        if self.activeChild == .person {
            self.hide(child: self.personsViewController)
            self.display(child: self.groupsViewController)
            self.activeChild = .group
        } else {
            self.hide(child: self.groupsViewController)
            self.display(child: self.personsViewController)
            self.activeChild = .person
        }
    }
    
    // MARK: - View setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Randomizer"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - View Interaction
    
    @objc public func randomizeGroups() {
        debugPrint("🚨 Randomizing groups")
        
        let groups = self.randomizer.randomize()
        
        self.groupsViewController.groups = groups
        self.display(child: .group)
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
                self.randomizer.people.append(person)
                self.personsViewController.tableView.reloadData()
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
            textField.text = "\(self.randomizer.numberOfGroups)"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let numberOfGroups = alert.textFields?[0].text {
                self.randomizer.numberOfGroups = Int(numberOfGroups) ?? 2
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc public func showGroups() {
        self.display(child: .group)
    }
    
    @objc private func showPersons() {
        self.display(child: .person)
    }
}
