//
//  SettingsViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class SettingsViewController: UITableViewController {
    
    // MARK: - View Variables
    
    // MARK: - Variables
    
    private var model: SettingsModel
    
    fileprivate var cellIdentifier = "cell"
    
    public var delegate: SettingsViewControllerDelegate?
    
    // MARK: - Initializers
    
    public init(model: SettingsModel) {
        self.model = model
        super.init(style: .grouped)
        self.model.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    // MARK: - View Setup
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - SettingsViewController TableView Extension

extension SettingsViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.sectionModels.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.sectionModels[section].cellModels.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.model.sectionModels[section].headerText
    }
    
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.model.sectionModels[section].footerText
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footer = view as? UITableViewHeaderFooterView {
            footer.textLabel?.textAlignment = self.model.sectionModels[section].footerTextAlignment
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = self.model.sectionModels[indexPath.section].cellModels[indexPath.row]
        
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellType.reuseIdentifier()) else {
                return UITableViewCell(style: cellModel.cellType.style(), reuseIdentifier: cellModel.cellType.reuseIdentifier())
            }
            return cell
        }()
        
        cell.textLabel?.text = cellModel.text
        cell.detailTextLabel?.text = cellModel.detailText
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = cellModel.action.indicator()
        cell.tintColor = UIColor(named: "lightBlue")
        
        if cellModel.action == .none {
            cell.selectionStyle = .none
        } else {
            cell.selectionStyle = .default
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = self.model.sectionModels[indexPath.section].cellModels[indexPath.row]
        
        guard cellModel.action != .none else {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        
        self.delegate?.purchaseTip(index: indexPath.row)
    }
    
}

// MARK: - SettingsViewController model delegate

extension SettingsViewController: SettingsModelDelegate {
    
    public func modelDidChange() {
        self.tableView.reloadData()
    }
    
}
