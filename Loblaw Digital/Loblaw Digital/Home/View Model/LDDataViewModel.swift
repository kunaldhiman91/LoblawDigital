//
//  LDDataViewModel.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-09-02.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
import UIKit.UIImage

class LDDataViewModel: NSObject, LDNewsFeedCellViewModeling {
    
    private var data :ChildData
    
    private var imageFetcher: LDImageFetcher = LDImageFetcher()
    
    var title: String? {
        if let title = self.data.title {
            return title
        }
        return nil
    }
    
    var subTitle: String? {
        if let subTitle = self.data.selftext {
            return subTitle
        }
        return nil
    }
    
    var shouldHideImage: Bool {
        
        if let urlString = self.data.thumbnail, let url = URL(string: urlString), url.isValidURL() {
            return false
        }
        return true
    }
    
    init(data: ChildData) {
        self.data = data
    }
   
    func fetchImage(completion: @escaping ((UIImage?) -> Void)) {

        if self.shouldHideImage {
            completion(nil)
            return
        }
        
        guard let urlString = self.data.thumbnail, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        self.imageFetcher.fetchImage(url: url) { (result) in
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

extension LDDataViewModel {
    
    override var description: String {
        return "title = \(String(describing: self.title)) + thumbnqail = \(String(describing: self.data.thumbnail))"
    }
    
}
