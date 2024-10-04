//
//  CollectionView+Extension.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

extension UICollectionView {
    func registerXIBCell(type: UICollectionViewCell.Type) {
        let identifier = String(describing: type)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}
