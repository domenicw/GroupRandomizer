//
//  PersonListTableViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 17.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PersonListViewController: RandomizeViewController {
    
    // MARK: - View Variables
    
    public var delegate: PersonListViewControllerDelegate?
    
    /// Randomizer
    var model: [Person] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    public init(model: [Person]) {
        self.model = model
        
        super.init()
        
        self.navigationItem.rightBarButtonItems = [createAddItem(), createEditItem()]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.title = "People"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "personCell")
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: - View Creation
    
    private func createAddItem() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPerson))
        addButton.tintColor =  .lightBlue
        
        return addButton
    }
    
    private func createEditItem() -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editPersonList))
        button.tintColor = .lightBlue
        
        return button
    }
    
    private func createDoneItem() -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneEditing))
        button.tintColor = .lightBlue
        
        return button
    }
    
    // MARK: - View Interaction
    
    @objc public func addPerson() {
        debugPrint("🚨 Adding person")
        
        self.delegate?.addPerson()
    }
    
    @objc private func editPersonList() {
        self.tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItems = [createDoneItem()]
    }
    
    @objc private func doneEditing() {
        self.tableView.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItems = [createAddItem(), createEditItem()]
    }
    
    @objc private func changeNameOfPerson(index: Int) {
        debugPrint("🚨 Changing Persons Name")
        
        self.delegate?.editNameOfPerson(index)
    }
    
    @objc public override func randomizeGroups() {
        self.delegate?.randomize()
    }
}

// MARK: - Class Extension

extension PersonListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.delegate?.removePerson(indexPath.row)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeNameOfPerson(index: indexPath.row)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension PersonListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.model[indexPath.row].name
        cell.selectionStyle = .default
        
        return cell
    }
    
}
