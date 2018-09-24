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
            let tipJarCell = SettingsCellModel(text: product.localizedTitle, detailText: product.localizedPrice, action: .tipJar, cellType: .tipJar)
            return tipJarCell
        }
        
        let tipJarSection = SettingsSectionModel(headerText: SettingsText.tipJarHeaderText.localized, footerText: SettingsText.tipJarFooterText.localized, cellModels: cellModels)
        
        self.sectionModels.insert(tipJarSection, at: 1)
    }
    
}

extension SettingsModel {
    
    public static func create() -> SettingsModel {
        let infoCell = SettingsCellModel(text: SettingsText.appInfoText.localized, action: .none)
        let infoSection = SettingsSectionModel(headerText: SettingsText.appInfoTitle.localized, footerText: nil, cellModels: [infoCell])
        
        var disclosureFooterText: String
        if let release = Bundle.main.releaseVersionNumber, let build = Bundle.main.buildVersionNumber {
            let baseString = SettingsText.appInfoDisclosureFooterTextWithVersion.localized
            disclosureFooterText = String(format: baseString, release, build)
        } else {
            disclosureFooterText = SettingsText.appInfoDisclosureFooterTextNoVersion.localized
        }
        let disclosureSection: SettingsSectionModel = SettingsSectionModel(headerText: nil, footerText: disclosureFooterText, cellModels: [], footerTextAlignment: .center)
        
        let model = SettingsModel(sectionModels: [infoSection, disclosureSection])
        
        return model
    }
    
}
