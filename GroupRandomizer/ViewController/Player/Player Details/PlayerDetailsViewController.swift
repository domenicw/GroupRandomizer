//
//  PlayerDetailsViewController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerDetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    public enum State {
        case `default`
        case edit
        case newPlayer
    }
    
    public var state: State = .default {
        didSet {
            switch state {
            case .default:
                self.addButton.isEnabled = false
                self.addButton.isHidden = true
                self.avatarImageView.state = .default
                self.nameInputView.dataInputTextView.isUserInteractionEnabled = false
                self.detailInputView.dataInputTextView.isUserInteractionEnabled = false
                self.navigationItem.leftBarButtonItem = nil
            case .edit:
                self.addButton.isEnabled = true
                self.addButton.isHidden = false
                self.avatarImageView.state = .editable
                self.nameInputView.dataInputTextView.isUserInteractionEnabled = true
                self.detailInputView.dataInputTextView.isUserInteractionEnabled = true
                self.addButton.setTitle("Save Player", for: .normal)
                self.navigationItem.leftBarButtonItem = nil
            case .newPlayer:
                self.addButton.isEnabled = true
                self.addButton.isHidden = false
                self.avatarImageView.state = .editable
                self.nameInputView.dataInputTextView.isUserInteractionEnabled = true
                self.detailInputView.dataInputTextView.isUserInteractionEnabled = true
                self.addButton.setTitle("Add Player", for: .normal)
            }
        }
    }
    
    public var delegate: PlayerDetailsViewControllerDelegate?
    
    // MARK: - View Variables
    
    public lazy private(set) var avatarImageView: AvatarView = {
        let view = AvatarView()
        view.style = .round
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy public private(set) var nameInputView: DataInputView = {
        let view = DataInputView()
        view.titleLabel.text = "Name"
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy public private(set) var detailInputView: DataInputView = {
        let view = DataInputView()
        view.titleLabel.text = "Details"
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy public private(set) var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Player", for: .normal)
        button.setBackgroundColor(.lightBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray1, for: .highlighted)
        button.addTarget(self, action: #selector(self.addPlayer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func setupView() {
        // Add all subviews to view
        self.view.addSubview(self.avatarImageView)
        self.view.addSubview(self.nameInputView)
        self.view.addSubview(self.detailInputView)
        self.view.addSubview(self.addButton)
        
        // Set constraints
        self.applyAvatarImageViewConstraints()
        self.applyNameInputViewConstraints()
        self.applyDetailInputViewConstraints()
        self.applyAddButtonConstraints()
        
        // Create and add cancel button
        self.createCancelBarButton()
    }
    
    private func applyAvatarImageViewConstraints() {
        self.avatarImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        self.avatarImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.avatarImageView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        self.avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
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
    
    private func applyAddButtonConstraints() {
        self.addButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
        self.addButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.addButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func createCancelBarButton() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelView))
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
        
        self.setupFirstResponder()
    }
    
    public func setup(with player: Player) {
        self.nameInputView.dataInputTextView.text = player.name
        self.title = player.name
    }
    
    // MARK: - View Interaction
    
    @objc private func hideKeyboard() {
        self.nameInputView.dataInputTextView.resignFirstResponder()
        self.detailInputView.dataInputTextView.resignFirstResponder()
    }
    
    @objc private func addPlayer() {
        if let name = self.nameInputView.dataInputTextView.text {
            let player = Player(name: name)
            self.delegate?.save(player)
        }
    }
    
    @objc private func cancelView() {
        self.delegate?.cancel()
    }
}
