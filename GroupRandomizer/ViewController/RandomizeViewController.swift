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
    
    /// Randomizer
    public let randomizer: Randomizer
    
    private var activeChild: ActiveChildViewController = .person
    
    // MARK: - Private types
    
    fileprivate enum ActiveChildViewController {
        case person
        case group
    }
    
    // MARK: - Inizializers
    
    public init() {
        self.randomizer = Randomizer(numberOfGroups: 2, people: [])
        
        super.init(nibName: nil, bundle: nil)
        self.randomizeButton = createRandomButton()
        self.view.addSubview(self.randomizeButton)
        
        self.groupsButton = self.createGroupsButton()
        self.view.addSubview(self.groupsButton)
        
        self.personsButton = self.createPersonsButton()
        self.view.addSubview(self.personsButton)
        
        self.personsViewController = self.createPersonListViewController()
        self.addChild(self.personsViewController)
        self.view.addSubview(self.personsViewController.view)
        self.personsViewController.didMove(toParent: self)
        
        self.applyRandomButtonConstraints()
        self.applyPersonsButtonConstraints()
        self.applyGroupsButtonConstraints()
        self.applyChildViewControllerConstraints(viewController: self.personsViewController)
        
        self.addAddItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createRandomButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Randomize", for: .normal)
        button.backgroundColor = UIColor(red: 28/255, green: 34/255, blue: 200/255, alpha: 0.75)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.randomizeGroups), for: .touchUpInside)
        
        return button
    }
    
    private func applyRandomButtonConstraints() {
        NSLayoutConstraint(item: self.randomizeButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    private func createGroupsButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Groups", for: .normal)
        button.backgroundColor = UIColor(red: 28/255, green: 34/255, blue: 200/255, alpha: 0.75)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.changeNumberOfGroups), for: .touchUpInside)
        
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
        button.backgroundColor = UIColor(red: 28/255, green: 34/255, blue: 200/255, alpha: 0.75)
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
    
    private func applyChildViewControllerConstraints(viewController: UIViewController) {
        NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: self.personsButton, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .bottom, relatedBy: .equal, toItem: self.randomizeButton, attribute: .top, multiplier: 1, constant: -10).isActive = true
    }
    
    private func addAddItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPerson))
        addButton.tintColor = UIColor(red: 28/255, green: 34/255, blue: 200/255, alpha: 0.75)
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - View setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Randomizer"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - View Interaction
    
    @objc public func randomizeGroups() {
        print("🚨 Randomizing groups")
        
        let groups = self.randomizer.randomize()
        for group in groups {
            print("-------")
            for person in group.people {
                print(person.name)
            }
        }
    }
    
    @objc public func addPerson() {
        print("🚨 Adding person")
        
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
        print("🚨 Changeing number of groups")
        
        let alert = UIAlertController(title: "Number of Groups", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "\(self.randomizer.numberOfGroups)"
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
    
    @objc private func showPersons() {
        let personListViewController = PersonListTableViewController(randomizer: self.randomizer)
        self.navigationController?.pushViewController(personListViewController, animated: true)
    }

}
