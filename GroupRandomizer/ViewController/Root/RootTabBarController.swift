//
//  RootTabBarController.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class RootTabBarController: UITabBarController {
    
    // MARK: - View Setup
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isOpaque = false
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.gray1
        self.tabBar.tintColor = UIColor.lightBlue
        self.tabBar.unselectedItemTintColor = UIColor.gray2

    }
    
}
