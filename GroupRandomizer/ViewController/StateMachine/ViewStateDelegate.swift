//
//  ViewStateDelegate.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation

public protocol ViewStateDelegate {
    
    func enter(_ state: ViewState.State)
    
}
