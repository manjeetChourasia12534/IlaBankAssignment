//
//  CountryHomeVC+TableViewExtension.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

extension CountryHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .countryCarosal:
            return 1
        case .spotsList:
            return viewModel.touristSpots.isEmpty ? 1 : viewModel.touristSpots.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .countryCarosal:
            guard let carouselCell = tableView.dequeueReusableCell(withIdentifier: CountryImageCarouselTableViewCell.identifier) as? CountryImageCarouselTableViewCell else {
                return UITableViewCell()
            }
            carouselCell.countryList = viewModel.countries
            carouselCell.pageControl.currentPage = viewModel.selectedIndex
            carouselCell.updateBottomView = { [weak self] currentIndex in
                guard let self = self else { return }
                self.searchHeaderView?.clearSearchedText()
                self.viewModel.selectedIndex = currentIndex
            }
            return carouselCell
        case .spotsList:
            if viewModel.touristSpots.isEmpty {
                guard let noDataCell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.identifier) as? NoDataTableViewCell else {
                    return UITableViewCell()
                 }
                return noDataCell
            } else {
                guard let touristSpotCell = tableView.dequeueReusableCell(withIdentifier: TouristSpotTableViewCell.identifier) as? TouristSpotTableViewCell else {
                    return UITableViewCell()
                }
                touristSpotCell.touristSpot = viewModel.touristSpots[indexPath.row]
                return touristSpotCell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .countryCarosal:
            return UIScreen.main.bounds.height * 0.25
        case .spotsList:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sections[section] {
        case .spotsList:
            searchHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchHeaderView.identifier) as? SearchHeaderView
            searchHeaderView?.searchBar.delegate = self
            return searchHeaderView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .spotsList:
            return 60
        default:
            return 0
        }
    }
}
