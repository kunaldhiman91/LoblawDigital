//
//  LDRequestConfig.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

protocol LDURLBuilder {
    // End point for the request
    var endPoint: String { get }
    
    // Http Method to be used.
    var httpMethod: LDHttpMethod { get }
    
    // http method for communication. eg. PUT, POST, DELETE, GET
    var requestType: LDRequestType { get }
    
}

public enum LDHttpMethod: String {
    // Use https for request
    case https
    
    // Use http for the request
    case http
    
}

public enum LDRequestType: String {
    // Use GET Method
    case GET
    
    // Use POST Method
    case POST
    
    // Use PUT Method
    case PUT
    
    // Use DELETE Method
    case DELETE
    
}

public enum LDRequestError: Error {
    // 404 Encountered.
    case encountered404
    
    // Other error encountered.
    case otherError(errorCode: Int)
    
}
