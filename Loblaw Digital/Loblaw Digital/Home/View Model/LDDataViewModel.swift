//
//  LDDataViewModel.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-09-02.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation
import UIKit.UIImage

/// This class holds the data of each news node.
final class LDDataViewModel: LDNewsFeedCellViewModeling {
    
    // MARK: Public Properties
    
    /// The Title of Swift News.
    var title: String? {
        if let title = self.data.title {
            return title
        }
        return nil
    }
    
    /// The subTitle/details of Swift News.
    var subTitle: String? {
        if let subTitle = self.data.selftext {
            return subTitle
        }
        return nil
    }
    
    /// Bool indicating whether image is available or not.
    var shouldHideImage: Bool {
        
        if let urlString = self.data.thumbnail, let url = URL(string: urlString), url.isValidURL() {
            return false
        }
        return true
    }
    
    // MARK: Private Properties
    private var data :SwiftNewsDataNode
    
    private static let imageFetcher: LDImageFetcher = LDImageFetcher()
    
    // MARK: Initialiser
    init(data: SwiftNewsDataNode) {
        self.data = data
    }
   
    // MARK: Public methods
    
    /**
     Fetch image for news feed from backend.
     
     - Parameters:
     - completion: completion block providing image in the completion block.
     
     - Returns: Void.
     */
    func fetchImage(completion: @escaping ((UIImage?) -> Void)) {
        if self.shouldHideImage {
            completion(nil)
            return
        }
        guard let urlString = self.data.thumbnail, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        LDDataViewModel.imageFetcher.fetchImage(url: url) { (result) in
            switch result {
            case .success (let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
