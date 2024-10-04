//
//  CountryViewModel.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

enum SectionTypes: Int, CaseIterable {
    case countryCarosal
    case spotsList
}

class CountryViewModel {
    var countries: [Country] = []
    var touristSpots: [TouristSpot] = []
    var selectedIndex: Int = 0 {
        didSet {
            searchText.removeAll()
            updateTouristSpots()
        }
    }
    var errorMessage: String?
    var searchText: String = "" {
        didSet {
            updateTouristSpots()
        }
    }
    let sections = SectionTypes.allCases
    var reloadData: ((Bool) -> Void)?

    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
        Task {
            await loadCountryData()
        }
    }

    private func loadCountryData() async {
        errorMessage = nil

        do {
            let countryModel: CountryModel = try await dataService.fetchCountryData(fileName: FileConstants.countryData, extensionType: FileConstants.jsonExtension)
            countries = countryModel.countries
            updateTouristSpots()
            reloadData?(true)
        } catch {
            errorMessage = error.localizedDescription
            reloadData?(false)
        }
    }

    private func updateTouristSpots() {
        guard !countries.isEmpty else {
            touristSpots = []
            return
        }

        let data = countries[selectedIndex].touristSpots
        touristSpots = searchText.isEmpty ? data : data.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        reloadData?(true)
    }
}

// MARK: - extentions
extension CountryViewModel {
    func getStatisticsData() -> (Int, [[Character: Int]]) {
        let listCount = touristSpots.count
        let charCount: [Character: Int] = touristSpots
            .flatMap { $0.name.uppercased() }
            .filter { !$0.isWhitespace }
            .reduce(into: [Character: Int]()) { count, char in
                count[char, default: 0] += 1
            }

        let top3CharCounts = charCount
            .sorted(by: { $0.value > $1.value })
            .prefix(3)
            .map { [$0.key: $0.value] }
        
        return (listCount, top3CharCounts)
    }

    func getNavigationTitle() -> String {
        return countries.isEmpty ? "Country List" : countries[selectedIndex].country
    }
}
