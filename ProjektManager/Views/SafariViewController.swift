//
//  SafariViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 10.01.23.
//

import UIKit
import WebKit

class SafariViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL laden
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        //erlaubt das vor und zurück
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        
        // searchBar
        searchBar.text = url.absoluteString
        searchBar.delegate = self
        // er macht nicht automatisch den ersten Buchstaben gross
        searchBar.autocapitalizationType = .none

   }
    @IBAction func forwardPressed(_sender: UIButton){
        webView.goForward()
    }
    @IBAction func backwardPressed(_sender: UIButton){
        webView.goBack()
    }
    
}
        // Dynamische Anpassung der SearchBarTextes
extension SafariViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.searchBar.text = webView.url!.absoluteString
    }
    
}
        // Suche über SearchBar einrichten
extension SafariViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text!
        searchBar.resignFirstResponder()
        let newURL = URL(string: "https://\(searchText).com")!
        webView.load(URLRequest(url: newURL))
        searchBar.text = newURL.absoluteString
    }
    
}
