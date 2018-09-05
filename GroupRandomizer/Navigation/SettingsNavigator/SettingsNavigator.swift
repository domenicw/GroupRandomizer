//
//  SettingsNavigator.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

public class SettingsNavigator: Navigator {
    
    // MARK: - Variables
    
    public var navigationController: UINavigationController
    
    public var model: SettingsModel
    
    private var storeHelper: SKIAPHelper
    
    // MARK: - Initializers
    
    public init() {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        
        self.model = SettingsModel.create()
        self.storeHelper = SKIAPHelper()
        self.storeHelper.delegate = self
        self.storeHelper.fetchAvailableProducts()
        
        let settingsViewController = SettingsViewController(model: self.model)
        settingsViewController.delegate = self
        navigationController.pushViewController(settingsViewController, animated: false)
    }
    
}

extension SettingsNavigator: SettingsViewControllerDelegate {
    
    public func purchaseTip(index: Int) {
        self.storeHelper.purchase(index)
    }
    
}

extension SettingsNavigator: SKStoreDelegate {
    
    func storeProductsResponse(products: [SKProduct]) {
        self.model.add(products: products)
    }
    
    func purchaseWasSuccessful() {
        let alert = UIAlertController(title: "Thank you 😊", message: "Thank you so much for your tip. I am very grateful.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(dismiss)
        self.navigationController.present(alert, animated: true, completion: nil)
    }
    
}
