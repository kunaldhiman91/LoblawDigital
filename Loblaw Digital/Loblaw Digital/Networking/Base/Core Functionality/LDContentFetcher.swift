//
//  LDContentFetcher.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

typealias completionHandler = (Result<Data, LDRequestError>) -> Void

class LDContentFetcher: NSObject {
    
    // MARK: Public methods
    
    /**
     Send out request to a URL providing a completion handler.
     
     - Parameters:
     - request: The URLRequest required to send out the request.
     - completionHandler: The completion handler that handles the response and error.
     
     - Returns: Void.
     
     - Throws: `LDRequestError`
     */
    
    // shared Instance of LDContentFetcher.
    static let shared = LDContentFetcher()
    
    private override init() {}
    
    func requestContent(request: URLRequest?, completionHandler: @escaping completionHandler) {
        
        // Creating a session
        let session = URLSession.shared
        
        let task = session.dataTask(with: request!) { (data, response, error) in
            
            // Check if request returns an error.
            if let localError = error as NSError? {
                
                switch localError.code {
                    
                default:
                    completionHandler(.failure(LDRequestError.otherError(errorCode: localError.code)))
                    
                }
                return
            }
            
            // Request does not return error.
            if let localData = data, let urlResponse = response as? HTTPURLResponse {
                
                switch urlResponse.statusCode {
                    
                case 200...399:
                    completionHandler(.success(localData))
                case 404:
                     completionHandler(.failure(LDRequestError.encountered404))
                default:
                    completionHandler(.failure(LDRequestError.otherError(errorCode: urlResponse.statusCode)))
                    
                }
            }
        }
        task.resume()
    }
}
