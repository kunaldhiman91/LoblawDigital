//
//  LDRequestBuilder.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

protocol RequestBuilder {
    func buildURLRequest<T: LDURLBuilder>(withURL url: T, andParameters parameters: [String: String]) throws -> URLRequest
}

public enum BuilderError: Error {
    case unableToResolveURL(URL)
    case unableBuildURL(message: String)
}

class NetworkRequestBuilder: RequestBuilder {
    
    func buildURLRequest<T: LDURLBuilder>(withURL url: T, andParameters parameters: [String: String]) throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = url.httpMethod.rawValue
        components.host = NetworkConstant.baseURL
        components.path = url.endPoint
        
        var queryItems = [URLQueryItem]()
        for key in parameters.keys.sorted() {
            guard let param = parameters[key] else { continue }
            queryItems.append(URLQueryItem(name: key, value: param))
        }
        components.queryItems = queryItems
        
        guard let localUrl = components.url else {
            let errorMessage = components.queryItems?.map { String(describing: $0) }.joined(separator: ", ") ?? ""
            
            throw BuilderError.unableBuildURL(message: "query item \(errorMessage)")
        }
        
        var request = URLRequest(url: localUrl,
                          cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                          timeoutInterval: 30)
        request.httpMethod = url.httpMethod.rawValue
        
        return request
    }
}
