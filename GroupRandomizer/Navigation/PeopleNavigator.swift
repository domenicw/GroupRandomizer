//
//  PeopleNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 30.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class PeopleNavigator: Navigator {
    
    // MARK: - Variables
    
    public var delegate: RootNavigatorDelegate?
    
    public var model: RandomizerModel
    
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    public init(model: RandomizerModel) {
        let nav = UINavigationController()
        self.navigationController = nav
        
        self.model = model
        
        let randomizeController = RandomizeViewController(model: model, activeChild: .person)
        randomizeController.delegate = self
        self.navigationController.pushViewController(randomizeController, animated: false)
    }
    
}

extension PeopleNavigator: RandomizeViewControllerDelegate {
    
    public func randomize() {
        self.delegate?.randomize()
    }
    
}
