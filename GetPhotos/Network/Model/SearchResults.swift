//
//  SearchResults.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplasPhotos]
}

struct UnsplasPhotos: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: [UrlKind.RawValue: String]
    let user: UserInfo
    
    enum UrlKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct UserInfo: Decodable {
    let name: String
}

