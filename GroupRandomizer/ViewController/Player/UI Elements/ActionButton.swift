//
//  ActionButton.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class ActionButton: UIButton {
    
    // MARK: - Variables
    
    public enum Style {
        case delete
        case actions
    }
    
    public var style: Style = .actions {
        didSet {
            self.change(style)
        }
    }
    
    // MARK: - View Style
    
    private func change(_ style: Style) {
        switch style {
        case .delete:
            self.applyDeleteStyle()
        case .actions:
            self.applyActionStyle()
        }
    }
    
    private func applyActionStyle() {
        self.setBackgroundColor(.gray1, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.setTitle("delete", for: .normal)
    }
    
    private func applyDeleteStyle() {
        self.setBackgroundColor(.red, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setTitle("-", for: .normal)
        
        
        //let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.bounds.width / , height: self.bounds.height / 5), byRoundingCorners: <#T##UIRectCorner#>, cornerRadii: <#T##CGSize#>)
    }
    
    // MARK: - View layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.change(self.style)
        
        // Make button round
        self.layer.cornerRadius = self.bounds.height / 2
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: self.bounds.height)
    }
    
}
