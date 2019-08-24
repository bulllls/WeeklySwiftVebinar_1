//
//  SearchResults.swift
//  WeeklySwift#1(PhotosLibrary)
//
//  Created by Ruslan on 8/24/19.
//  Copyright © 2019 Ruslan Filistovich. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
