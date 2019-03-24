//
//  PlayerCreationAvatarView.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerCreationAvatarView: UIView {
    
    // MARK: - Variables
    
    public enum ImageStyle {
        case round
        case corner(radius: CGFloat)
        case square
    }
    
    public var style: ImageStyle = .round {
        didSet {
            self.layoutSubviews()
        }
    }
    
    public enum State {
        case editable
        case `default`
    }
    
    public var state: State = .default {
        didSet {
            var addHidden = false
            var removeHidden = true
            switch state {
            case .default:
                addHidden = true
                removeHidden = true
            case .editable:
                if let _ = self.avatarImageView.image {
                    addHidden = true
                    removeHidden = false
                } else {
                    addHidden = false
                    removeHidden = true
                }
            }
            
            self.addAvatarButton.isHidden = addHidden
            self.addAvatarButton.isEnabled = !addHidden
            self.removeAvatarButton.isHidden = removeHidden
            self.removeAvatarButton.isEnabled = !removeHidden
        }
    }
    
    // MARK: - View Variables
    
    public lazy private(set) var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public lazy private(set) var addAvatarButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitle("+\nAdd Avatar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray1, for: .highlighted)
        button.setBackgroundImage(UIImage(), for: .normal)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.addTarget(self, action: #selector(self.addAvatar), for: .touchUpInside)
        
        let sizeAttributeLarge = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)]
        let title = NSMutableAttributedString(string: "+", attributes: sizeAttributeLarge)
        title.append(NSAttributedString(string: "\n"))
        let sizeAttributeSmall = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)]
        title.append(NSMutableAttributedString(string: "Add Avatar", attributes: sizeAttributeSmall))
        button.titleLabel?.attributedText = title
        
        return button
    }()
    
    public lazy private(set) var removeAvatarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.isHidden = true
        button.isEnabled = false
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.removeAvatar), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initializers
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.addSubviewElements()
        self.applyElementConstraints()
        self.state = .editable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func addSubviewElements() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.addAvatarButton)
        self.addSubview(self.removeAvatarButton)
    }
    
    // MARK: - View Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var cornerRadius: CGFloat = 0.0
        switch self.style {
        case .round:
            cornerRadius = self.avatarImageView.frame.height / 2
        case .corner(let radius):
            cornerRadius = radius
        case .square:
            cornerRadius = 0
        }
        
        self.avatarImageView.layer.cornerRadius = cornerRadius
        self.addAvatarButton.layer.cornerRadius = cornerRadius
    }
    
    private func applyElementConstraints() {
        // Avatar Image View
        self.avatarImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        self.avatarImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        self.avatarImageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        self.avatarImageView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor).isActive = true
        
        // Add Avatar Button
        self.addAvatarButton.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor).isActive = true
        self.addAvatarButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor).isActive = true
        self.addAvatarButton.bottomAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor).isActive = true
        self.addAvatarButton.trailingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor).isActive = true
        
        // Remove Button
        self.removeAvatarButton.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor).isActive = true
        self.removeAvatarButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor).isActive = true
        self.removeAvatarButton.heightAnchor.constraint(equalTo: self.removeAvatarButton.widthAnchor).isActive = true
        self.removeAvatarButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: - View Setup
    
    // MARK: - View Interaction
    
    @objc public func removeAvatar() {
        self.avatarImageView.image = nil
        self.removeAvatarButton.isHidden = true
        self.removeAvatarButton.isEnabled = false
        self.addAvatarButton.isHidden = false
        self.addAvatarButton.isEnabled = true
    }
    
    @objc public func addAvatar() {
        self.setAvatar(UIImage())
        debugPrint("add avatar")
    }
    
    public func setAvatar(_ image: UIImage) {
        self.avatarImageView.image = image
        self.removeAvatarButton.isHidden = false
        self.removeAvatarButton.isEnabled = true
        self.addAvatarButton.isHidden = true
        self.addAvatarButton.isEnabled = false
    }
    
}


