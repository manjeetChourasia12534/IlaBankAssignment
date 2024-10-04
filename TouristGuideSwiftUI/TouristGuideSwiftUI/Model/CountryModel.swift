//
//  CountryModel.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

struct CountryModel: Codable {
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let country, image: String
    let touristSpots: [TouristSpot]

    enum CodingKeys: String, CodingKey {
        case country, image
        case touristSpots = "tourist_spots"
    }
}

// MARK: - TouristSpot
struct TouristSpot: Codable, Hashable {
    let name, location, description, image: String
}
