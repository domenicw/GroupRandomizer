//
//  ContinuousNavigationController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class ContinuousNavigationController: UINavigationController {
    
    // MARK: - View Setup
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Removes divider and sets white background to navigation bar
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor = .lightBlue
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.prefersLargeTitles = true
    }
    
}
