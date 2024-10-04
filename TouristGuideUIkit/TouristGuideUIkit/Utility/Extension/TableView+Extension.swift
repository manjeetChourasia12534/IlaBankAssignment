//
//  TableView+Extension.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

extension UITableView {
    func registerXIBCell(type: UITableViewCell.Type) {
        let identifier = String(describing: type)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterView(className: UITableViewHeaderFooterView.Type) {
        let identifier = String(describing: className)
        self.register(className.self, forHeaderFooterViewReuseIdentifier: identifier)
        
    }
}
