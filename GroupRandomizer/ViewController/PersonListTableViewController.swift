//
//  PersonListTableViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 17.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PersonListTableViewController: UITableViewController {
    
    // MARK: - View Variables
    
    var randomizer: Randomizer
    
    // MARK: - Initializers
    
    public init(randomizer: Randomizer) {
        self.randomizer = randomizer
        
        super.init(nibName: nil, bundle: nil)
        
        //self.addAddButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View creation
    /*
    private func addAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPerson))
        self.navigationItem.rightBarButtonItem = addItem
    }
    */
    // MARK: - View Setup
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "personCell")
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    // MARK: - View Interaction
    /*
    @objc private func addPerson() {
        debugPrint("🚨 Adding Person")
        
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name of person"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                let person = Person(name: name)
                self.randomizer.people.append(person)
                self.tableView.reloadData()
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
 */
}

extension PersonListTableViewController {
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.randomizer.people[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.randomizer.people.count
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.randomizer.people.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    public override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
