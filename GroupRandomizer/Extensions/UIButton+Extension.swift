//
//  UIButton+Extension.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: size))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.clipsToBounds = true
        self.setBackgroundImage(image, for: state)
    }
    
}
