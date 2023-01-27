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

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Hallo \(eingeloggterUser!.name ?? "")"
    }
    

    @IBAction func exitApp(){
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }

}

