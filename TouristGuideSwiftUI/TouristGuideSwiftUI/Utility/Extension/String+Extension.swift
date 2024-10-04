//
//  String+Extension.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", comment: "")
    }
}
