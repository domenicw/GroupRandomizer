//
//  GroupsListTableViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 18.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class GroupsListTableViewController: UITableViewController {
    
    // MARK: - View Variables
    
    // MARK: - Variables
    
    /// Randomizer model
    public var model: RandomizerModel
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        model.add(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        self.model.remove(delegate: self)
    }
    
    // MARK: - View Creation
    
    // MARK: - View Set up
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - Class Extension

extension GroupsListTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.groups.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.groups[section].people.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Group Nr. \(section+1)"
        return title
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.model.groups[indexPath.section].people[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
}

extension GroupsListTableViewController: RandomizerModelDelegate {
    
    public func groupsDidChange() {
        self.tableView.reloadData()
    }
    
    public func peopleDidChange() {}
}
