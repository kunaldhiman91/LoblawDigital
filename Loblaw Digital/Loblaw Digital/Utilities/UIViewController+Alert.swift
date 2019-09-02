//
//  UIViewController+Alert.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

extension UIViewController {
    
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
