//
//  ArticleViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 01.02.23.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let stringURL = article?.url else {return}
        guard let url = URL(string: stringURL) else {return}
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url:url))
        }

   
    }

}
