//
//  DataService.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

protocol DataServiceProtocol {
    func fetchCountryData<T: Decodable>(fileName: String,
                                        extensionType: String) -> Result<T, DataServiceError>
}

class DataService: DataServiceProtocol {
    func fetchCountryData<T>(fileName: String, extensionType: String) -> Result<T, DataServiceError> where T : Decodable {
        // Using Bundle extension to fetch URL
        guard let url = Bundle.main.urlForResource(fileName, withExtension: extensionType) else {
            return .failure(.fileNotFound)
        }

        do {
            // Read the data from the file
            let data = try Data(contentsOf: url)

            // Decode the JSON data
            let decoder = JSONDecoder()
            let countryModel = try decoder.decode(T.self, from: data)
            return .success(countryModel)
        } catch {
            // Handle any errors that occurred while reading or decoding the data
            if (error as NSError).domain == NSCocoaErrorDomain && (error as NSError).code == NSFileReadNoSuchFileError {
                return .failure(.fileNotFound)
            } else if (error as NSError).domain == NSCocoaErrorDomain && (error as NSError).code == NSFileReadCorruptFileError {
                return .failure(.decodingError(error))
            } else {
                return .failure(.decodingError(error))
            }
        }
    }
}
