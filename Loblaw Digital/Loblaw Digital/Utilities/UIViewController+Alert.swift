//
//  UIViewController+Alert.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import UIKit


extension UIViewController {
    /// Show Network alert on viewController.
    ///
    /// - Parameter title: Title for alert
    /// - Parameter message: message for alert
    /// - Parameter handler: handler for alert.
    func showNetworkAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
