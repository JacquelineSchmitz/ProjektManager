//
//  LoginViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 04.01.23.
//

struct LoginUser {
    var email: String
    var password: String
}


import UIKit

class LoginViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users: [User]?
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.keyboardType = .emailAddress
        passwordField.isSecureTextEntry = true
        
        emailField.delegate = self
        passwordField.delegate = self
        fetchUser()
        
    }
    
    
    
    
    
    
    // DISMISS KEYBOARD OUTSIDE
    
    @objc func dismissKeyboardTouchOutside(){
        self.view.endEditing(true)
    }
    func keyboardDismissable() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    //DATATANSFER
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        wir speichern den TabBarController in einer variable
        let destinationVC = segue.destination as! UITabBarController
        //        wir greifen auf das 1te tab des tabBarControllers [0]
        let userVc = destinationVC.viewControllers?[0] as! UserViewController
        //        wir geben den user vom loginController zum userViewController
        let enteringUser = sender as? User
        userVc.user = enteringUser!
        
    }
    
    func fetchUser() {
        
        do {
            self.users = try context.fetch(User.fetchRequest())
        } catch {
            print("error")
        }
    }
    
    /*@IBAction func buttonPressed() {
     let email = emailField.text ?? ""
     let password = passwordField.text ?? ""
     let enteringUser = EnteringUser(email: email, password: password)
     performSegue(withIdentifier: "EnterUserSegue", sender: enteringUser)
     }*/
    
    @IBAction func button_tapped(_ sender: Any) {
        //        funktiniert nur mit einem angemeldeten user
        
        //        for i in 0...users!.count - 1 {
        //            if  (users![i].email == emailField.text && users![i].password == passwordField.text) {
        //                performSegue(withIdentifier: "show_second", sender: self.users![i])
        //                break
        //            }
        //        }
        for user in users! {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            if  (user.email == emailField.text && user.password == passwordField.text) {
                eingeloggterUser = user
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                break
            }
        }
    }
    
}

// TEXTFIELDS
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        default: self.view.endEditing(true)
        }
        return true
    }
}

