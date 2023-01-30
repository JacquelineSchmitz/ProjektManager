//
//  NewsApiClient.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 30.01.23.
//

import Foundation
import UIKit

private let baseUrl = "https://newsapi.org"
private let apikey = "2c008a4cb216458bb4a1a11b5691dfc6"

enum NewsApiEndpoints: String {
    case everything = "/v2/everything"
    case headlines = "/v2/top-headlines"
    case sources = "/v2/top-headlines/sources"
}

struct NewsApiClient {
    func fetchNews(){
        
    }
    func fetchHeadlines(){
        
    }
//    func fetchImageBy(URL: URL, completionHandler: @escaping(UIImage) -> Void){
//        let session = URLSession.shared
//        let downloadTask = session,downloadTask(with: URL) { data, response. error in
//            if(data != nil && error == nil) {
//                do {
//                    let rawData = try Data(contentsOf: data!)
//                    guard let image = UIImage(data: rawData) else {return}
//                    completionHandler(image)
//                }catch{
//                    print("Error: \(error)")
//                }
//            }
//        }
//        downloadTask.resume()
//    }
}
