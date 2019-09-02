//
//  URL+Validity.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-09-02.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
import UIKit.UIApplication

extension URL {
    
    func isValidURL() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
