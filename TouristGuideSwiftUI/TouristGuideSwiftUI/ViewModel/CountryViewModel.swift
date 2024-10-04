//
//  CountryViewModel.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import Foundation

class CountryViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var touristSpots: [TouristSpot] = []
    @Published var selectedIndex: Int = 0 {
        didSet {
            searchText.removeAll()
            updateTouristSpots()
        }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            updateTouristSpots()
        }
    }

    private let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
        loadCountryData()
    }

    private func loadCountryData() {
        isLoading = true
        errorMessage = nil

        // Fetch country data
        let dataResult: Result<CountryModel, DataServiceError> = dataService.fetchCountryData(
            fileName: FileConstants.countryData,
            extensionType: FileConstants.jsonExtension
        )

        // Handle the result
        handleCountryDataResult(dataResult)
    }

    private func handleCountryDataResult(_ result: Result<CountryModel, DataServiceError>) {
        DispatchQueue.main.async {
            self.isLoading = false

            switch result {
            case .success(let countryModel):
                self.countries = countryModel.countries
                self.updateTouristSpots()
            case .failure(let error):
                self.errorMessage = self.errorMessage(for: error)
            }
        }
    }

    private func updateTouristSpots() {
        guard !countries.isEmpty else {
            touristSpots = []
            return
        }
        let data = countries[selectedIndex].touristSpots
        touristSpots = searchText.isEmpty ? data : data.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    private func errorMessage(for error: DataServiceError) -> String {
        switch error {
        case .fileNotFound:
            return ErrorMessage.fileNotFound
        case .noData:
            return ErrorMessage.noData
        case .decodingError(let decodingError):
            return ErrorMessage.decodingError + decodingError.localizedDescription
        }
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
