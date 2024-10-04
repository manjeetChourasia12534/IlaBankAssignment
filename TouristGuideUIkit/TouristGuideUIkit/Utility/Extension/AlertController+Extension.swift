//
//  AlertController+Extension.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

extension UIAlertController {
    static func createAlert(title: String, message: String, actionTitle: String = "OK", actionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle,
                                   style: .default,
                                   handler: actionHandler)
        alertController.addAction(action)
        return alertController
    }

    func present(from viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: animated, completion: completion)
    }
}
