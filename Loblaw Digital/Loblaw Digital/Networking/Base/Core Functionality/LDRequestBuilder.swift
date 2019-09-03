//
//  LDRequestBuilder.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation

/// Protocol to design a new URL Request.
protocol RequestBuilder {
    /// Building a request with a URL
    func buildURLRequest(withURL url: URL) -> URLRequest
    /// Building a request with a LDURLBuilder and parameters.
    func buildURLRequest<T: LDURLBuilder>(withURLBuilder urlBuilder: T, andParameters parameters: [String: String]) throws -> URLRequest
}

/// Error thrown during request building.
public enum BuilderError: Error {
    case unableToResolveURL(URL)
    case unableBuildURL(message: String)
}

class NetworkRequestBuilder: RequestBuilder {

    /**
     Building a request with a URL
     
     - Parameters:
     - url: The URL for the request.
     
     - Returns: URLRequest.
     */
    func buildURLRequest(withURL url: URL) -> URLRequest {
        
        return URLRequest(url: url,
                          cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                          timeoutInterval: 30)
        
    }
    
    /**
     Building a request with a LDURLBuilder and parameters.
     
     - Parameters:
     - withURLBuilder: The type conforming to LDURLBuilder.
     - andParameters: The parameters for request.
     - Returns: URLRequest.
     */
    func buildURLRequest<T: LDURLBuilder>(withURLBuilder urlBuilder: T, andParameters parameters: [String: String]) throws -> URLRequest {
        
        var components = URLComponents()
        if let httpMethod = urlBuilder.httpMethod {
            components.scheme = httpMethod.rawValue
        }
        
        components.host = NetworkConstant.baseURL
        components.path = urlBuilder.endPoint
        
        if parameters.count > 0 {
            var queryItems = [URLQueryItem]()
            for key in parameters.keys.sorted() {
                guard let param = parameters[key] else { continue }
                queryItems.append(URLQueryItem(name: key, value: param))
            }
            components.queryItems = queryItems
        }
        
        guard let localUrl = components.url else {
            let errorMessage = components.queryItems?.map { String(describing: $0) }.joined(separator: ", ") ?? ""
            
            throw BuilderError.unableBuildURL(message: "query item \(errorMessage)")
        }
        
        var urlrequest = URLRequest(url: localUrl,
                                    cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                                    timeoutInterval: 30)
        if let requestType = urlBuilder.requestType {
            urlrequest.httpMethod = requestType.rawValue
        }
        return urlrequest
        
    }
}
