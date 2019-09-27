//
//  LDHomeViewModel.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-30.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation
import UIKit.UIImage

/// This class stores the data of each news node.
final class LDHomeViewModel: NSObject {

    // Data Object that contains news data object. - readonly
    private (set) var newsDataObject: LDDataObject?
    
    let newsRequest = LDHomeServiceRequest()
    
    // MARK: Properties
    
    /// data containing all the news feed.
    var data: [LDDataViewModel] = [LDDataViewModel]()

    // MARK: Public methods
    
    /**
     Fetch News Details from backend.
     
     - Parameters:
     - completion: completion block with no params.
     
     - Returns: Void.
     */
    
    func fetchNewsDetails(completion: @escaping () -> Void) {
    
        
        do {
            var requestParams: [String: String] = [:]
            if let localNewsData = self.newsDataObject, let afterHash = localNewsData.data.after {
                requestParams["after"] = afterHash
            }

            try newsRequest.requestData(withParameters: requestParams,
                                        model: LDDataObject.self,
                                        completionHandler: { (model) in
                                            guard let _model = model else {
                                                                                           print("Error: Couldn't decode data")
                                                                                           return
                                                                                       }
                                                                                       
                                                                                       self.newsDataObject = _model as? LDDataObject
                                                                                       let newNewsFeed = self.newsDataObject?.data.children.map({ (child) in
                                                                                           return LDDataViewModel(data: child.data)
                                                                                       })
                                                                                       
                                                                                       if let localNewNewsFeed = newNewsFeed {
                                                                                            self.data.append(contentsOf: localNewNewsFeed)
                                                                                       }
                                                                                      
                                                                                       completion()
            })
        } catch (let error){
            print(error.localizedDescription)
        }
    }
}
