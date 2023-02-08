//
//  UserViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 04.01.23.
//

import UIKit

class UserViewController: UIViewController {
    
    
    
    var user: User!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var newsTableView: UITableView!
    var articles:  [Article]?
    var newsApiClient = NewsApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        fetchNews()
        //        articles = mockData
        
        nameLabel.text = "Hallo \(eingeloggterUser!.name ?? "")"
    }
    
    func fetchNews() {
        newsApiClient.fetchNews { news in
            self.articles = news.articles
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ArticleViewController else {return}
        guard let article = sender as? Article else {return}
        destination.article = article
    }
    
    
    @IBAction func exitApp(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginController)
        
        
    }
    
}

// NewsViewController

// TableView Data Source
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        guard let article = articles?[indexPath.row] else {return cell}
        
        cell.titelLabel.text = article.title ?? "Unbekannter Titel"
        cell.descriptionLabel.text = article.description ?? "Keine Beschreibung vorhanden"
        guard let stringURL = article.urlToImage else {return cell}
        guard let imageURL = URL(string: stringURL) else {return cell}
        newsApiClient.fetchImageBy(URL: imageURL) { image in
            DispatchQueue.main.async {
                cell.newsImageView.image = image
            }
        }
        
        return cell
    }
}

// TableView Delegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedArticle = articles?[indexPath.row] else {return}
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showArticleSegue", sender: selectedArticle)
    }
}
