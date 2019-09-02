//
//  LDHomeViewModel.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-30.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class LDHomeViewModel: NSObject {

    // Data Object that contains news data object. - readonly
    private (set) var newsDataObject: LDDataObject?
    
    var data: [LDDataViewModel]?

    func fetchNewsDetails(completion: @escaping () -> Void) {
        
        let newsRequest = LDHomeServiceRequest()
        do {
            try newsRequest.requestData(model: LDDataObject.self,
                                        completionHandler: { (model) in
                                            guard let _model = model else {
                                                print("Error: Couldn't decode data")
                                                return
                                            }
                                            
                                            self.newsDataObject = _model as? LDDataObject
                                            self.data = self.newsDataObject?.data.children.map({ (child) in
                                                return LDDataViewModel(data: child.data)
                                            })
                                            completion()
                                            
            })
        } catch {
            
        }
    }
}
