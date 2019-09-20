//
//  LDHomeModel.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-29.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation

// MARK: LDDataObject
struct LDDataObject: Decodable {
    let kind: String?
    let data: LDData 
}

// MARK: LDData
struct LDData: Decodable {
    let modhash: String?
    let dist: Int?
    let children: [SwiftNewsData]
    let after: String?
    let before: String?
}

// MARK: - SwiftNewsData
struct SwiftNewsData: Decodable {
    let kind: String?
    let data: SwiftNewsDataNode
}

// MARK: - SwiftNewsDataNode
struct SwiftNewsDataNode: Decodable {
    let title: String?
    let thumbnail: String?
    let selftext: String?
    
}
