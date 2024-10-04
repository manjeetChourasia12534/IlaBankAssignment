//
//  TouristSpotTableViewCell.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

class TouristSpotTableViewCell: UITableViewCell {

    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotTitle: UILabel!
    @IBOutlet weak var spotDescription: UILabel!
    @IBOutlet weak var containerView: UIView!

    var touristSpot: TouristSpot? {
        didSet {
            setUpCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        spotImage.layer.cornerRadius =  10
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func setUpCell() {
        if let image = touristSpot?.image {
            spotImage.image = UIImage(named: image)
        } else {
            spotImage.image = UIImage(systemName: "photo.artframe")
        }
        spotTitle.text = touristSpot?.name ?? ""
        spotDescription.text = touristSpot?.description ?? ""
    }
    
}
