//
//  DataServiceError.swift
//  TouristGuideUIkit
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
            return ErrorMessages.fileNotFound
        case .noData:
            return ErrorMessages.noData
        case .decodingError(let error):
            return "\(ErrorMessages.decodingError): \(error.localizedDescription)"
        }
    }
}
