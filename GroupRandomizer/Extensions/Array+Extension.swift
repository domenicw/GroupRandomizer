//
//  Array+Extension.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 15.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

extension Array {
    
    public func split(in numberOfArrays: Int) -> [[Element]] {
        let chunkSize = self.count / numberOfArrays
        let arrays = self.splitBy(chunkSize: chunkSize)
        
        return arrays
    }
    
    public func splitBy(chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
    
}
