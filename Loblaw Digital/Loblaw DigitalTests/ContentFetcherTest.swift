//
//  ContentFetcherTest.swift
//  Loblaw DigitalTests
//
//  Created by Kunal Kumar on 2019-09-27.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
@testable import Loblaw_Digital
import XCTest

class ContentFetcherMock: LDContentFetcher {
    
    
    let jsonStringData: String? = nil
    
    override func requestContent(request: URLRequest?, completionHandler: @escaping completionHandler) {
            
        
    
        
        let json = """
                    {
                    "kind": "Listing",
                    "data": {
                    "modhash": "z4f76ik5o5d2e048977c58390990ed677a72f2913b5d238485",
                    "dist": 27,
                    "children": [],
                    "after": "t3_d9axyy",
                    "before": null
                    }
                    }
                    """
        
    
        let mockData = json.data(using: .utf8)
        
        completionHandler(.success(mockData!))
    }
    
}
