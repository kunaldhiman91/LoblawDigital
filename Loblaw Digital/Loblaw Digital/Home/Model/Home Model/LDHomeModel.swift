//
//  LDHomeModel.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-29.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

struct LDDataObject: Decodable {
    let kind: String?
    let data: LDData
}

struct LDData: Decodable {
    
    let modhash: String?
    let dist: Int?
    let children: [Child]
    let after: String?
    let before: String?
}

// MARK: - Child
struct Child: Decodable {
    let kind: String?
    let data: ChildData
}

struct ChildData: Decodable {
    
    let title: String?
    let thumbnail: String?
    let selftext: String?
    
}
