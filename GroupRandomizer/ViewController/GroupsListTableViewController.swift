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
    
    /// Randomizer
    public var groups: [Group] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    public init(groups: [Group]) {
        self.groups = groups
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return self.groups.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups[section].people.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Group Nr. \(section+1)"
        return title
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.groups[indexPath.section].people[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
}
