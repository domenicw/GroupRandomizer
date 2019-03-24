//
//  PlayerCreationViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerCreationViewController: UIViewController {
    
    // MARK: - Variables
    
    public var delegate: PlayerCreationViewControllerDelegate?
    
    // MARK: - View Variables
    
    public lazy private(set) var avatarImageView: PlayerCreationAvatarView = {
        let view = PlayerCreationAvatarView()
        view.style = .round
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        return view
    }()
    
    public private(set) var nameInputView: PlayerCreationDataInputView!
    
    public private(set) var detailInputView: PlayerCreationDataInputView!
    
    public private(set) var addButton: UIButton!
    
    // MARK: - Initializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.nameInputView = self.createDataInputView()
        self.nameInputView.titleLabel.text = "Name"
        self.view.addSubview(self.nameInputView)
        
        self.detailInputView = self.createDataInputView()
        self.detailInputView.titleLabel.text = "Details"
        self.view.addSubview(self.detailInputView)
        
        self.addButton = self.createAddButton()
        self.view.addSubview(self.addButton)
        
        self.applyAvatarImageViewConstraints()
        self.applyNameInputViewConstraints()
        self.applyDetailInputViewConstraints()
        self.applyAddButtonConstraints()
        
        self.createCancelBarButton()
        self.setupFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func applyAvatarImageViewConstraints() {
        self.avatarImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        self.avatarImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.avatarImageView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        self.avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func createDataInputView() -> PlayerCreationDataInputView {
        let view = PlayerCreationDataInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func applyNameInputViewConstraints() {
        self.nameInputView.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 30).isActive = true
        self.nameInputView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.nameInputView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    private func applyDetailInputViewConstraints() {
        self.detailInputView.topAnchor.constraint(equalTo: self.nameInputView.bottomAnchor, constant: 10).isActive = true
        self.detailInputView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.detailInputView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    private func createAddButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Add Player", for: .normal)
        button.backgroundColor = UIColor.lightBlue
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray1, for: .highlighted)
        button.addTarget(self, action: #selector(self.addPlayer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    private func applyAddButtonConstraints() {
        self.addButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
        self.addButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.addButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func createCancelBarButton() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelCreation))
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    // MARK: - View Setup
    
    private func setupFirstResponder() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        recognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(recognizer)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Create New Player"
    }
    
    // MARK: - View Interaction
    
    @objc private func hideKeyboard() {
        self.nameInputView.dataInputTextView.resignFirstResponder()
        self.detailInputView.dataInputTextView.resignFirstResponder()
    }
    
    @objc private func addPlayer() {
        self.delegate?.addPlayer(with: self.nameInputView.dataInputTextView.text!)
    }
    
    @objc private func cancelCreation() {
        self.delegate?.cancelCreation()
    }
}
