//
//  LDImageFetcher.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-30.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation
import UIKit.UIImage

/// Error to be displayed when image downloading fails
enum ImageFetcherError: Error {
    case imageURLNil
    case unableToFetchImage
}

class LDImageFetcher {
    
    private let urlRequestBuilder = NetworkRequestBuilder()
    
    /// NSCache object used to cache image for key
    static let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(url: URL?, completionHandler: @escaping (Result<UIImage, ImageFetcherError>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(ImageFetcherError.imageURLNil))
            return
        }
        
        if let cachedImage = type(of: self).cache.object(forKey: url.absoluteString as NSString) {
            // we have image
            print("image found at cache -- URL == \(url.absoluteString)")
            completionHandler(.success(cachedImage))
            return
        }
        
        let urlRequest = urlRequestBuilder.buildURLRequest(withURL: url)
        
        LDContentFetcher.shared.requestContent(request: urlRequest) { (result) in
            
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completionHandler(.failure(ImageFetcherError.unableToFetchImage))
                    return
                }
                
                type(of: self).cache.setObject(image, forKey: url.absoluteString as NSString)
                completionHandler(.success(image))
                
            case .failure( _):
                completionHandler(.failure(ImageFetcherError.unableToFetchImage))
            }
        }
    }
}
