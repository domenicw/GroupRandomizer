//
//  GroupsListTableViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 18.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class GroupsListViewController: RandomizeViewController {
    
    // MARK: - View Variables
    
    public var delegate: GroupsListViewControllerDelegate?
    
    // MARK: - Variables
    
    /// Randomizer model
    public var model: [Group] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    public init(model: [Group]) {
        self.model = model
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItems = [createNumberOfGroupsItem()]
        
        self.title = GroupsText.viewTitle.localized
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createNumberOfGroupsItem() -> UIBarButtonItem {
        let numberButton = UIBarButtonItem(title: "Nr.", style: .done, target: self, action: #selector(self.changeNumberOfGroups))
        numberButton.tintColor = .lightBlue
        
        return numberButton
    }
    
    // MARK: - View Set up
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: - View Interaction
    
    @objc public func changeNumberOfGroups() {
        debugPrint("🚨 Changeing number of groups")
        
        self.delegate?.changeNumberOfGroups()
    }
    
    public override func randomizeGroups() {
        self.delegate?.randomize()
    }
}

// MARK: - Class Extension

extension GroupsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model[section].people.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let baseString = GroupsText.sectionGroupTitle.localized
        let title = String(format: baseString, String(describing: section+1))
        return title
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.model[indexPath.section].people[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
}
