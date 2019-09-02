//
//  LDGomeServiceRequest.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-29.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation

/// Home Service Request for getting Swift News Feed.
class LDHomeServiceRequest: LDServiceRequest {}

extension LDHomeServiceRequest {
    var endPoint: String {
        return "/r/swift/.json"
    }
    
    var httpMethod: LDHttpMethod? {
        return .https
    }
    
    var requestType: LDRequestType? {
        return .GET
    }
}
