//
//  ToDoViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 10.01.23.
//

import Foundation
import UIKit

class ToDoViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var zuErledigen = ["Werkzeug für Objekt 009 ins Auto laden"]
    var erledigt: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func startEditing(_ sender: Any) {
        
        
        tableView.isEditing = !tableView.isEditing
        
    }
    
    //    @IBAction func deleteRow(_ sender: Any) {
    //        if let selectedRows = tableView.indexPathsForSelectedRows {
    //            var items = [String]()
    //            for indexPath in selectedRows {
    //                items.append(zuErledigen[indexPath.row])
    //            }
    //            for item in items {
    //                if let index = zuErledigen.firstIndex(of: item) {
    //                    zuErledigen.remove(at: index)
    //                }
    //            }
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: selectedRows, with: .automatic)
    //            tableView.endUpdates()
    //        }
    //    }
    
    @IBAction func hinzufuegen() {
        let alert = UIAlertController(title: "Hinzufügen", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel))
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default, handler: {(_) in
            let text = alert.textFields?.first?.text
            self.zuErledigen.append(text!)
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true)
    }
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView)-> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return zuErledigen.count
        } else {
            return erledigt.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "zuErledigen", for: indexPath)
        if indexPath.section == 0{
            var content = cell.defaultContentConfiguration()
            content.text = zuErledigen[indexPath.row]
            cell.contentConfiguration = content
            cell.accessoryType = .none
        }else{
            if indexPath.section == 1{
                var content = cell.defaultContentConfiguration()
                content.text = erledigt[indexPath.row]
                cell.contentConfiguration = content
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Noch zuErledigen"
        } else {
            return "Schon erledigt"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            if indexPath.section == 0{
                zuErledigen.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }else{
                erledigt.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.isEditing == false){
            if indexPath.section == 0{
                let data = zuErledigen[indexPath.row]
                erledigt.append(data)
                zuErledigen.remove(at: indexPath.row)
            }else if indexPath.section == 1{
                let data = erledigt[indexPath.row]
                zuErledigen.append(data)
                erledigt.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
        
    }
    
}
