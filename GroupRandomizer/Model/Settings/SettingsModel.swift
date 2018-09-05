//
//  SettingsModel.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

public class SettingsModel {
    
    // MARK: - Variables
    
    public var delegate: SettingsModelDelegate?
    
    public private(set) var sectionModels: [SettingsSectionModel] {
        didSet {
            delegate?.modelDidChange()
        }
    }
    
    // MARK: - Initializers
    
    public init(sectionModels: [SettingsSectionModel]) {
        self.sectionModels = sectionModels
    }
    
    // MARK: - In App Purchase Loaded
    
    public func add(products: [SKProduct]) {
        let cellModels = products.map { (product) -> SettingsCellModel in
            print(String(describing: product.priceLocale))
            let tipJarCell = SettingsCellModel(text: product.localizedTitle, detailText: product.localizedPrice, action: .tipJar, cellType: .tipJar)
 /Users/domenic/Desktop/GroupRandomizer/GroupRandomizer/Model/Settings/SettingsModel.swift           return tipJarCell
        }
        
        let tipJarSection = SettingsSectionModel(headerText: "Tip Jar", footerText: "Thank you for supporting my work 😊", cellModels: cellModels)
        
        self.sectionModels.insert(tipJarSection, at: 1)
    }
    
}

extension SettingsModel {
    
    public static func create() -> SettingsModel {
        let infoCell = SettingsCellModel(text: "Randomizer takes the hard part out of making game groups. Quickly add people and assign them randomly to your desired number of groups.", action: .none)
        let infoSection = SettingsSectionModel(headerText: "Information", footerText: nil, cellModels: [infoCell])
        
        var disclosureFooterText: String
        if let release = Bundle.main.releaseVersionNumber, let build = Bundle.main.buildVersionNumber {
            disclosureFooterText = "Domenic Wüthrich © 2018\nVersion \(release) (\(build))"
        } else {
            disclosureFooterText = "Domenic Wüthrich © 2018"
        }
        let disclosureSection: SettingsSectionModel = SettingsSectionModel(headerText: nil, footerText: disclosureFooterText, cellModels: [], footerTextAlignment: .center)
        
        let model = SettingsModel(sectionModels: [infoSection, disclosureSection])
        
        return model
    }
    
}
