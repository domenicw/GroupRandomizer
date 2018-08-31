//
//  SKStoreDelegate.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import StoreKit

/**
 App Store delegate
 
 */
protocol SKStoreDelegate {
    
    /// App stoer response of SKProducts
    /// - Parameter products: Array of SKProducts
    func storeProductsResponse(products: [SKProduct])
    
    
    /// Called when purchase was successful
    func purchaseWasSuccessful()
    
}
