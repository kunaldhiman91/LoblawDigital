//
//  threadUtil.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-30.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

/// Executes provided closure on main thred
///
/// - Parameter workItem: Work item closure to be executed
func performOnMain(_ workItem: @escaping () -> Void) {
    if Thread.isMainThread {
        workItem()
    } else {
        DispatchQueue.main.async {
            workItem()
        }
    }
}
