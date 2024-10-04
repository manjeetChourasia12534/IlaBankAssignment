//
//  CountryHomeViewController.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

class CountryHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingBtn: UIButton!
    var viewModel: CountryViewModel = CountryViewModel()
    var searchHeaderView: SearchHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureViewModel()
    }

    // MARK: - Setup Methods
    private func setUpUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        floatingBtn.transform = CGAffineTransform(rotationAngle: .pi / 2)
        floatingBtn.setTitle("", for: .normal)
        registerCell()
        updateNavigationTitle()
    }
    
    private func registerCell() {
        tableView.registerXIBCell(type: TouristSpotTableViewCell.self)
        tableView.registerXIBCell(type: CountryImageCarouselTableViewCell.self)
        tableView.registerXIBCell(type: NoDataTableViewCell.self)
        tableView.registerHeaderFooterView(className: SearchHeaderView.self)
    }

    private func configureViewModel() {
        viewModel.reloadData = { [weak self] status in
            self?.handleViewModelUpdate(status: status)
        }
    }

    private func handleViewModelUpdate(status: Bool) {
        if status {
            refreshTableView()
            updateNavigationTitle()
        } else {
            if let errorMessage = viewModel.errorMessage {
               presentErrorAlert(message: errorMessage)
           }
        }
    }

    private func updateNavigationTitle() {
        self.title = viewModel.getNavigationTitle()
    }
    
    private func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func floatingButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let bottomSheetVC = storyboard.instantiateViewController(withIdentifier: "StatisticsDataSheetViewController") as? StatisticsDataSheetViewController {
            bottomSheetVC.data = viewModel.getStatisticsData()
            self.present(bottomSheetVC, animated: true)
        }
        
    }
}

// MARK: - UISearchBarDelegate
extension CountryHomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            if searchText.isEmpty {
                searchBar.searchTextField.resignFirstResponder()
            }
        })
    }
}

// MARK: - Alert Presentation
extension CountryHomeViewController {
    private func presentErrorAlert(message: String) {
        let alert = UIAlertController.createAlert(title: "errorTitle".localized, message: message)
        alert.present(from: self)
    }
}
