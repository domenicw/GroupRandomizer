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
    
    /// Randomizer
    var randomizer: Randomizer
    
    // MARK: - Initializers
    
    public init(randomizer: Randomizer) {
        self.randomizer = randomizer
        
        super.init(nibName: nil, bundle: nil)
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
    
    // MARK: - View Interaction
    
    @objc private func changeNameOfPerson(index: Int) {
        debugPrint("🚨 Changing Persons Name")
        
        let alert = UIAlertController(title: "Change Name", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name of person"
            textField.text = self.randomizer.people[index].name
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                self.randomizer.people[index].name = name
                self.tableView.reloadData()
            }
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension PersonListTableViewController {
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.randomizer.people[indexPath.row].name
        cell.selectionStyle = .default
        
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
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeNameOfPerson(index: indexPath.row)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
