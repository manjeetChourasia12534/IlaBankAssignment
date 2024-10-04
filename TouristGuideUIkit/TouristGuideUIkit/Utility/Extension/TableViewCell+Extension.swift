//
//  TableViewCell+Extension.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        String(describing: self)
    }
}
