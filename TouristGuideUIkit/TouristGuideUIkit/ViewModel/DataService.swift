//
//  DataService.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

protocol DataServiceProtocol {
    func fetchCountryData<T: Decodable>(fileName: String, extensionType: String) async throws -> T
}

class DataService: DataServiceProtocol {
    
    func fetchCountryData<T: Decodable>(fileName: String, extensionType: String) async throws -> T {
        // Using Bundle extension to fetch URL
        guard let url = Bundle.main.urlForResource(fileName, withExtension: extensionType) else {
            throw DataServiceError.fileNotFound
        }

        do {
            // Read the data from the file
            let data = try Data(contentsOf: url)

            // Decode the JSON data
            let decoder = JSONDecoder()
            let countryModel = try decoder.decode(T.self, from: data)
            return countryModel
        } catch let error as NSError {
            
            // Handle file read or decoding errors
            if error.domain == NSCocoaErrorDomain {
                switch error.code {
                case NSFileReadNoSuchFileError:
                    throw DataServiceError.fileNotFound
                case NSFileReadNoPermissionError:
                    throw DataServiceError.noData
                default:
                    throw DataServiceError.decodingError(error)
                }
            } else {
                throw DataServiceError.decodingError(error)
            }
        }
    }
}
