//
//  PlayersListViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 17.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayersListViewController: RandomizeViewController {
    
    // MARK: - View Variables
    
    public var delegate: PlayersListViewControllerDelegate?
    
    private let cellIdentifier: String = "playerCell"
    
    /// Randomizer
    var model: [Player] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    public init(model: [Player]) {
        self.model = model
        
        super.init()
        
        self.navigationItem.rightBarButtonItems = [createAddItem(), createEditItem()]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.title = PlayersText.viewTitle.localized
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: - View Creation
    
    private func createAddItem() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPlayer))
        addButton.tintColor =  .lightBlue
        
        return addButton
    }
    
    private func createEditItem() -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editPlayerList))
        button.tintColor = .lightBlue
        
        return button
    }
    
    private func createDoneItem() -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneEditing))
        button.tintColor = .lightBlue
        
        return button
    }
    
    // MARK: - View Interaction
    
    @objc public func addPlayer() {
        debugPrint("🚨 Adding player")
        
        self.delegate?.addPlayer()
    }
    
    @objc private func editPlayerList() {
        self.tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItems = [createDoneItem()]
    }
    
    @objc private func doneEditing() {
        self.tableView.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItems = [createAddItem(), createEditItem()]
    }
    
    @objc private func changeNameOfPlayer(index: Int) {
        debugPrint("🚨 Changing player Name")
        
        self.delegate?.editNameOfPlayer(index)
    }
    
    @objc public override func randomizeGroups() {
        self.delegate?.randomize()
    }
}

// MARK: - Class Extension

extension PlayersListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.delegate?.removePlayer(indexPath.row)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.changeNameOfPlayer(index: indexPath.row)
        let playerViewController = PlayerDetailViewController()
        playerViewController.nameTextField.text = self.model[indexPath.row].name
        self.navigationController?.pushViewController(playerViewController, animated: true)
        
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension PlayersListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? PlayerTableViewCell else {
            return PlayerTableViewCell()
        }
        
        cell.nameLabel.text = self.model[indexPath.row].name
        cell.detailLabel.text = "Member of 2 groups"
        cell.selectionStyle = .default
        
        return cell
    }
    
}
