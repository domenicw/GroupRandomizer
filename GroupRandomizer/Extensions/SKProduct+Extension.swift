//
//  SKProduct+Extension.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 05.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import StoreKit

extension SKProduct {
    
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        if let priceFormatted = formatter.string(from: price) {
            return priceFormatted
        } else {
            return String(describing: price)
        }
    }
    
}
