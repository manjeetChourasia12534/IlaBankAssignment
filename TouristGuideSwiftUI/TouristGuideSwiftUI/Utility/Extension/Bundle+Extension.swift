//
//  Bundle+Extension.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

extension Bundle {
    func urlForResource(_ resource: String, withExtension ext: String) -> URL? {
        return self.url(forResource: resource, withExtension: ext)
    }
}
