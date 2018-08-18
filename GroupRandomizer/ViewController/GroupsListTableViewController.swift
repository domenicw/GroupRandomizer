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
    public var randomizer: Randomizer
    
    // MARK: - Initializers
    
    public init(randomizer: Randomizer) {
        self.randomizer = randomizer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GroupsListTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        #warning("rewrite this part")
        return self.randomizer.numberOfGroups
    }
    
}
