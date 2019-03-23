//
//  ViewState.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 23.03.19.
//  Copyright © 2019 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class ViewState {
    
    // MARK: - Variables
    
    public var state: State = .default {
        didSet {
            self.viewController.enter(state)
        }
    }
    
    private var viewController: ViewStateDelegate
    
    // MARK: - Initializers
    
    public init(_ viewController: ViewStateDelegate) {
        self.viewController = viewController
    }
    
    
}

public extension ViewState {
    
    public enum State {
        
        case `default`
        case editing
        
    }
    
}
