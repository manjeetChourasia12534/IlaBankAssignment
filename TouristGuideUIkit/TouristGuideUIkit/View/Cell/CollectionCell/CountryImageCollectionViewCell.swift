//
//  CountryImageCollectionViewCell.swift
//  TestAppUikit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

class CountryImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countryFlagImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        countryFlagImage.layer.cornerRadius = 12
    }
}
