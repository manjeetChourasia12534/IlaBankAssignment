//
//  StatisticsDataSheetViewController.swift
//  TestAppUikit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

class StatisticsDataSheetViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var statisticsDataLbl: UILabel!
    
    var data: (Int, [[Character: Int]])? {
        didSet {
            setupLblData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applyCornerRadius()
        contentView.backgroundColor = UIColor(named: "cellBackground")
    }

    private func setupLblData() {
        DispatchQueue.main.async {
            guard let data = self.data?.1, let totalList = self.data?.0 ,!data.isEmpty else {
                self.statisticsDataLbl.text = "NoData".localized
                return
            }

            var formattedString = "totalItemsLabel".localized + "\(totalList)\n\n"
            for item in data {
                if let (key, value) = item.first {
                    formattedString += " -> \(key): \(value)\n\n"
                }
            }
            self.statisticsDataLbl.text = formattedString
        }
    }

    private func applyCornerRadius() {
        let path = UIBezierPath(roundedRect: contentView.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 20, height: 20)) // Adjust corner radius as needed
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        contentView.layer.mask = mask
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyCornerRadius()
    }

    @IBAction func closeSheetAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
