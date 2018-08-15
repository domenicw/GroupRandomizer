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
    
    public var numberOfGroupsButton: UIButton!
    
    public let randomizer: Randomizer
    
    // MARK: - Inizializers
    
    public init() {
        self.randomizer = Randomizer(numberOfGroups: 2, people: [])
        
        super.init(nibName: nil, bundle: nil)
        self.randomizeButton = createRandomButton()
        self.view.addSubview(self.randomizeButton)
        self.applyRandomButtonConstraints()
        
        self.numberOfGroupsButton = self.createNumberOfGroupsButton()
        self.view.addSubview(self.numberOfGroupsButton)
        self.applyNumberOfGroupsButtonConstraints()
        
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
    
    private func createNumberOfGroupsButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Number of Groups: \(self.randomizer.numberOfGroups)", for: .normal)
        button.setTitleColor(UIColor(red: 28/255, green: 34/255, blue: 200/255, alpha: 0.75), for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.changeNumberOfGroups), for: .touchUpInside)
        
        return button
    }
    
    private func applyNumberOfGroupsButtonConstraints() {
        NSLayoutConstraint(item: self.numberOfGroupsButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: self.numberOfGroupsButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.numberOfGroupsButton, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.numberOfGroupsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
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
            self.numberOfGroupsButton.setTitle("Number of Groups: \(self.randomizer.numberOfGroups)", for: .normal)
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

}

