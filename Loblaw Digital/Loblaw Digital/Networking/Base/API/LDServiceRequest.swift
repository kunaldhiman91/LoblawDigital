//
//  LDServiceRequest.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

typealias serviceRequestCompletionHandler = (Bool, Data?) -> Void

protocol LDServiceRequest: LDURLBuilder {
    
    func requestData(completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void
    
    func requestData(withParameters parameters: [String: String],
                                      completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void
    
}

extension LDServiceRequest {
    
    func requestData(completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void {
        
        try self.requestData(withParameters: [:], completionHandler: completionHandler)
        
    }
    
    func requestData(withParameters parameters: [String: String],
                            completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void {
        
        let requestBuilder: NetworkRequestBuilder = NetworkRequestBuilder()
        
        var request: URLRequest?
        
        do {
            
            request = try requestBuilder.buildURLRequest(withURL: self,
                                                         andParameters: parameters)
            
        } catch (let error as BuilderError) {
            
            throw error
            
        }
        
        LDContentFetcher.shared.requestContent(request: request!) { (result) in
            switch result {
            case .success(let data):
                completionHandler(true, data)
            case .failure(let error):
                
                let title = "Sorry"
                var message = ""
                
                switch (error as LDRequestError) {
                    
                case .encountered404:
                    
                    message = "We are currently in maintainace mode. Please come back later."
                    
                case.otherError(let errorCode):
                    
                    message = "Unable to complete the request. Request error encountered - \(errorCode)"
                    
                }
                completionHandler(false, nil)
                
                DispatchQueue.main.async {
                    
                    guard let appDel = UIApplication.shared.delegate, let window = appDel.window, let rootVC = window?.rootViewController else {
                        completionHandler(false, nil)
                        return
                    }
                    
                    rootVC.showNetworkAlert(title: title,
                                            message: message,
                                            handler: nil)
                    
                }
            }
        }
    }
}
