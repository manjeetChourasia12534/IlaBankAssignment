//
//  DataServiceError.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

enum DataServiceError: Error {
    case fileNotFound
    case noData
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .fileNotFound:
            return "JSON file not found."
        case .noData:
            return "No data received."
        case .decodingError(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        }
    }
}
