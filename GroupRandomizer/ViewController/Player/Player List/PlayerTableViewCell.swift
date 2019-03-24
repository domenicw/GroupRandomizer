//
//  PlayerTableViewCell.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    
    // MARK: - View Variables
    
    public private(set) var avatarImageView: UIImageView!
    
    public private(set) var nameLabel: UILabel!
    
    public private(set) var detailLabel: UILabel!
    
    // MARK: - Initializers
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.avatarImageView = self.createAvatarImageView()
        self.addSubview(self.avatarImageView)
        
        self.nameLabel = self.createNameLabel()
        self.addSubview(self.nameLabel)
        
        self.detailLabel = self.createDetailLabel()
        self.addSubview(self.detailLabel)
        
        self.applyAvatarImageViewConstraints()
        self.applyNameLabelConstraints()
        self.applyDetailLabelConstraints()
        
        self.separatorInset = UIEdgeInsets(top: self.separatorInset.top, left: 70, bottom: self.separatorInset.bottom, right: self.separatorInset.right)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createAvatarImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .gray2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func applyAvatarImageViewConstraints() {
        self.avatarImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        self.avatarImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        self.avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func applyNameLabelConstraints() {
        self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    private func createDetailLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func applyDetailLabelConstraints() {
        self.detailLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5).isActive = true
        self.detailLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor).isActive = true
    }
    
    // MARK: - View Setup
    
}
