//
//  Navigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public protocol Navigator {
    
    var navigationController: UINavigationController { get set }
    
    var childNavigators: [Navigator] { get set }
    
}
