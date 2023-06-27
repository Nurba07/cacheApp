//
//  UnsplashModel.swift
//  CachingApp
//
//  Created by Nurbakhyt on 27.06.2023.
//

import UIKit
import Foundation


struct Unsplash: Decodable {
    let id: String
    let urls: Urls
}

// MARK: - Urls
struct Urls: Decodable {
    let raw: String
}
