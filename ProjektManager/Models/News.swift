//
//  News.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 30.01.23.
//

import Foundation

struct News: Codable {
    
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}
