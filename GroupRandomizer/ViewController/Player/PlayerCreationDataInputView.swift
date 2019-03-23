//
//  PlayerCreationDataInputView.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PlayerCreationDataInputView: UIView {
    
    // MARK: - Variables
    
    // MARK: - View Variables
    
    public private(set) var titleLabel: UILabel!
    
    public private(set) var dataInputTextView: UITextView!
    
    // MARK: - Initializers
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.titleLabel = self.createTitleLabel()
        self.addSubview(self.titleLabel)
        
        self.dataInputTextView = self.createDataInputTextView()
        self.addSubview(self.dataInputTextView)
        
        
        
        self.applyTitleLabelConstraints()
        self.applyDataInputTextView()
        self.setBackgroundAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Creation
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func applyTitleLabelConstraints() {
        self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 3).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        self.titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor, constant: -5).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func createDataInputTextView() -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = false
        view.backgroundColor = .none
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func applyDataInputTextView() {
        self.dataInputTextView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor).isActive = true
        self.dataInputTextView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10).isActive = true
        self.dataInputTextView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 3).isActive = true
        self.dataInputTextView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setBackgroundAppearance() {
        self.backgroundColor = .gray1
        self.layer.cornerRadius = 10
    }
    
    // MARK: - View Setup
    
}
