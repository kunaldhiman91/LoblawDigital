//
//  LDServiceRequest.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

typealias serviceRequestCompletionHandler = (Decodable?) -> Void

protocol LDServiceRequest: LDURLBuilder {
    
    func requestData<model: Decodable>(model m: model.Type,
                                       completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void
    
    func requestData<model: Decodable>(withParameters parameters: [String: String],
                                       model m:  model.Type,
                                       completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void
    
}

extension LDServiceRequest {
    
    func requestData<model: Decodable>(model m: model.Type,
                                       completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void {
        
        try self.requestData(withParameters: [:],
                             model: m.self,
                             completionHandler: completionHandler)
        
    }
    
    func requestData<model: Decodable>(withParameters parameters: [String: String],
                                       model m:  model.Type,
                                       completionHandler: @escaping serviceRequestCompletionHandler) throws -> Void {
        
        let requestBuilder: NetworkRequestBuilder = NetworkRequestBuilder()
        
        var request: URLRequest?
        
        do {
            request = try requestBuilder.buildURLRequest(withURLBuilder: self,
                                                         andParameters: parameters)
        } catch (let error as BuilderError) {
            completionHandler(nil)
            throw error
        }
        
        LDContentFetcher.shared.requestContent(request: request!) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let decodedModel = try JSONDecoder().decode(LDDataObject.self, from: data)
                    completionHandler(decodedModel)
                } catch (let error) {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
                
            case .failure(let error):
                
                let title = "Sorry"
                var message = ""
                
                switch (error as LDRequestError) {
                    
                case .encountered404:
                    
                    message = "We are currently in maintainace mode. Please come back later."
                    
                case.otherError(let errorCode):
                    
                    message = "Unable to complete the request. Request error encountered - \(errorCode)"
                    
                }
                completionHandler(nil)
                
                DispatchQueue.main.async {
                    
                    guard let appDel = UIApplication.shared.delegate, let window = appDel.window, let rootVC = window?.rootViewController else {
                        completionHandler(nil)
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
