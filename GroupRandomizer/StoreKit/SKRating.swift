//
//  SKRating.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import StoreKit

public class SKRating {
    
    private var numberOfGroupsRandomized = 0
    
    public func rate() {
        self.numberOfGroupsRandomized += 1
        
        guard self.numberOfGroupsRandomized == 3 else {
            return
        }
        
        self.requestReview()
    }
    
    /// Request a review (presents review controller)
    private func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
}
