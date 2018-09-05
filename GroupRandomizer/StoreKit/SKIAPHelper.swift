//
//  SKIAPHelper.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import StoreKit

public class SKIAPHelper: NSObject {
    
    // MARK: - Variables
    
    var delegate: SKStoreDelegate?
    
    private var purchaseProductID = ""
    
    public var productIDs: [String] {
        return [SKIAPItem.generousTip.rawValue]
    }
    
    private var iapProducts = [SKProduct]()
    
    private var productRequest = SKProductsRequest()
    
    private var canMakePurchase: Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    // MARK: - Functions
    
    public func purchase(_ index: Int) {
        guard index < self.iapProducts.count else {
            return
        }
        
        self.purchase(self.iapProducts[index])
    }
    
    public func purchase(_ product: SKProduct) {
        guard self.canMakePurchase else {
            return
        }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
        
        self.purchaseProductID = product.productIdentifier
    }
    
    public func fetchAvailableProducts() {
        let productIDs = Set(self.productIDs)
        self.productRequest = SKProductsRequest(productIdentifiers: productIDs)
        self.productRequest.delegate = self
        self.productRequest.start()
    }
    
}

// MARK: - Extensions
extension SKIAPHelper: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard response.products.count > 0 else { return }
        self.iapProducts = response.products
        self.delegate?.storeProductsResponse(products: self.iapProducts)
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                self.delegate?.purchaseWasSuccessful()
                queue.finishTransaction(transaction)
            case .failed:
                queue.finishTransaction(transaction)
            case .restored:
                queue.finishTransaction(transaction)
            default:
                break
            }
        }
    }
}
