//
//  SettingsText.swift
//  GroupRandomizer
//
//  Created by Domenic Wüthrich on 24.09.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum SettingsText: String, Localizable {
    
    // MARK: - String Cases
    
    case viewTitle = "view_title"
    case tipJarHeaderText = "tip_jar_header_text"
    case tipJarFooterText = "tip_jar_footer_text"
    case appInfoText = "app_info_text"
    case appInfoTitle = "app_info_title"
    case appInfoDisclosureFooterTextWithVersion = "app_info_disclosure_footer_text_with_version"
    case appInfoDisclosureFooterTextNoVersion = "app_info_disclosure_footer_text_no_version"
    
    // MARK: - Table
    
    public var tableName: String {
        return "Settings"
    }
    
}
