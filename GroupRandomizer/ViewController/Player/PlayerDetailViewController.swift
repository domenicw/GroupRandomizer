//
//  PlayerDetailViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerDetailViewController: UIViewController {
    
    // MARK: - View Variables
    
    public private(set) var nameTextField: UITextField!
    
    // MARK: - Variables
    
    public lazy var state: ViewState = ViewState(self)
    
    // MARK: - Initializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.title = "Player"
        
        self.nameTextField = self.createNameTextField()
        self.view.addSubview(self.nameTextField)
        self.applyNameTextFieldConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createNameTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Name"
        
        return textField
    }
    
    private func applyNameTextFieldConstraints() {
        self.nameTextField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        self.nameTextField.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        self.nameTextField.trailingAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func addEditBarButton() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.toggleState))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    private func addDoneBarButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.toggleState))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - View Setup
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.state.state = .default
    }
    
    // MARK: - View Interaction
    
    @objc private func toggleState() {
        switch self.state.state {
        case .default:
            self.state.state = .editing
        case .editing:
            self.state.state = .default
        }
    }
    
    
}

extension PlayerDetailViewController: ViewStateDelegate {
    
    public func enter(_ state: ViewState.State) {
        switch state {
        case .default:
            self.nameTextField.borderStyle = .none
            self.nameTextField.isUserInteractionEnabled = false
            self.nameTextField.isEnabled = false
            self.nameTextField.resignFirstResponder()
            self.addEditBarButton()
        case .editing:
            self.nameTextField.borderStyle = .roundedRect
            self.nameTextField.isUserInteractionEnabled = true
            self.nameTextField.isEnabled = true
            self.addDoneBarButton()
        }
    }
    
}
