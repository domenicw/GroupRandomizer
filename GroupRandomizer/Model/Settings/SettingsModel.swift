//
//  SettingsModel.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 31.08.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
import UIKit

public class SettingsModel {
    
    // MARK: - Variables
    
    var sectionModels: [SettingsSectionModel]
    
    // MARK: - Initializers
    
    public init(sectionModels: [SettingsSectionModel]) {
        self.sectionModels = sectionModels
    }

}

extension SettingsModel {
    
    public static func create() -> SettingsModel {
        let infoCell = SettingsCellModel(text: "Randomizer takes the hard part out of making game groups. Quickly add people and assign them randomly to your desired number of groups.", action: .none)
        let infoSection = SettingsSectionModel(headerText: "Info", footerText: nil, cellModels: [infoCell])
        
        let tipJarCell = SettingsCellModel(text: "Generous Tip", action: .tipJar)
        let tipJarSection = SettingsSectionModel(headerText: "Tip Jar", footerText: "Thank you for supporting my work 😊", cellModels: [tipJarCell])
        
        
        var disclosureFooterText: String
        if let release = Bundle.main.releaseVersionNumber, let build = Bundle.main.buildVersionNumber {
            disclosureFooterText = "Domenic Wüthrich © 2018\nVersion \(release) (\(build))"
        } else {
            disclosureFooterText = "Domenic Wüthrich © 2018"
        }
        let disclosureSection: SettingsSectionModel = SettingsSectionModel(headerText: nil, footerText: disclosureFooterText, cellModels: [], footerTextAlignment: .center)
        
        let model = SettingsModel(sectionModels: [infoSection, tipJarSection, disclosureSection])
        
        return model
    }
    
}
