//
//  NoDataTableViewCell.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

class NoDataTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 20
        cardView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
