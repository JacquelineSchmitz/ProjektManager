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



func buildURL(endpoint: NewsApiEndpoints, keyword: String = "News") -> String {
    if(endpoint == NewsApiEndpoints.everything) {
        return baseUrl + endpoint.rawValue + "?q=\(keyword)&apiKey=\(apikey)"
    } else {
        return baseUrl + endpoint.rawValue + "?country=de&apiKey=\(apikey)"
    }
}

struct NewsApiClient {
    func fetchNews(keyword: String = "News", completionHandler: @escaping(News) -> Void) {
        var newURL = buildURL(endpoint: NewsApiEndpoints.everything, keyword: keyword)
        newURL = newURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let url = URL(string: newURL) else {return}
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if(data != nil && error == nil) {
                do {
                    let news = try JSONDecoder().decode(News.self, from: data!)
                    completionHandler(news)
                } catch {
                    print("ERROR: \(error)")
                }
            }
        }
        dataTask.resume()
    }
//    func fetchHeadlines(completionHandler: @escaping(News) -> Void) {
//        var newURL = buildURL(endpoint: NewsApiEndpoints.headlines)
//        newURL = newURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//        guard let url = URL(string: newURL) else {return}
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url) { data, response, error in
//            if(data != nil && error == nil) {
//                do {
//                    let news = try JSONDecoder().decode(News.self, from: data!)
//                    completionHandler(news)
//                } catch {
//                    print("ERROR: \(error)")
//                }
//            }
//        }
//        dataTask.resume()
//    }
    
    func fetchImageBy(URL: URL, completionHandler: @escaping(UIImage) -> Void) {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: URL) { data, response, error in
            if(data != nil && error == nil) {
                do {
                    let rawData = try Data(contentsOf: data!)
                    guard let image = UIImage(data: rawData) else {return}
                    completionHandler(image)
                } catch {
                    print("ERROR: \(error)")
                }
            }
        }
        downloadTask.resume()
    }
}


