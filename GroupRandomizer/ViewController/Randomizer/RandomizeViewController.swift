//
//  RandomizeViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import UIKit

public class RandomizeViewController: UIViewController {
    
    // MARK: - View Variables
    
    /// Randomize button
    public private(set) var randomizeButton: UIButton!
    
    public private(set) var tableView: UITableView!
    
    // MARK: - Inizializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        // MARK: - View Creation
        self.tableView = self.createTableView()
        self.view.addSubview(self.tableView)
        
        self.randomizeButton = createRandomButton()
        self.view.addSubview(self.randomizeButton)
        
        // View Constraints
        self.applyTableViewConstraints()
        self.applyRandomButtonConstraints()
        
        // Misc
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createRandomButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(RandomizeText.randomizeButtonTitle.localized, for: .normal)
        button.backgroundColor = .lightBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.randomizeGroups), for: .touchUpInside)
        
        return button
    }
    
    private func applyRandomButtonConstraints() {
        NSLayoutConstraint(item: self.randomizeButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.randomizeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    private func createTableView() -> UITableView {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
 
    private func applyTableViewConstraints() {
        NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.randomizeButton, attribute: .top, multiplier: 1, constant: -10).isActive = true
    }
    
    // MARK: - View setup
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - View Interaction
    
    @objc public func randomizeGroups() {
        debugPrint("🚨 Randomizing groups")
    }
}
