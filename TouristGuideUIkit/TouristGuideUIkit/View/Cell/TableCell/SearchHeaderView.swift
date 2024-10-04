//
//  SearchHeaderView.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

class SearchHeaderView: UITableViewHeaderFooterView {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "searchPlaceholder".localized
        return searchBar
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func clearSearchedText() {
        searchBar.searchTextField.text?.removeAll()
        searchBar.searchTextField.resignFirstResponder()
    }
}

