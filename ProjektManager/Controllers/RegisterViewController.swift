//
//  RegisterViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 04.01.23.
//

/*struct User {
    var name: String
    var firma: String
    var gender: String
    var birthdate: String
    var email: String
    var password: String
}*/

import UIKit


class RegisterViewController: UIViewController {
    
    
    
    var user: [User]?
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firmaField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var birthdateField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let genders = ["Männlich","Weiblich","Divers"]
    let genderPicker = UIPickerView()
    let datePicker = UIDatePicker()
    
    let context = (UIApplication.shared.delegate as!
                   AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        keyboardDismissable()
        createDatePicker()
        
        registerButton.isEnabled = true
        emailField.keyboardType = .emailAddress
        passwordField.isSecureTextEntry = true
        
        nameField.delegate = self
        firmaField.delegate = self
        birthdateField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderField.inputView = genderPicker
        
        
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyBoardWillShow), name:
                                                UIResponder.keyboardDidHideNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyBoardWillHide), name:
                                                UIResponder.keyboardDidHideNotification, object: nil)
        
        func fetchUsers() {
            
            do {
                self.user = try context.fetch(User.fetchRequest())
                
                DispatchQueue.main.async {
                    self.view.reloadInputViews()
                }
            } catch {
                print("error")
            }
        }
        
    }
    
    @IBAction func saveUser(_ sender: UIButton!) {
        
         //Neuen Kontakt erzeugen
        let newUser = User(context: self.context)
        newUser.name = nameField.text
        newUser.gender = genderField.text
        let dateFormater = DateFormatter()
        newUser.birthdate = dateFormater.date(from: birthdateField.text!)
        newUser.password = passwordField.text
        newUser.email = emailField.text
        newUser.firma = firmaField.text
        
        // Save Data
        do{
            try self.context.save()
            print(newUser)
        } catch {
            print("error")
        }
        
        
        // Daten per Notificatiom Center Senden
        NotificationCenter.default.post(name: NSNotification.Name.init("de.ViewsWechseln.addUser"), object: newUser)
        
        self.dismiss(animated: true)
        performSegue(withIdentifier: "registerSegue", sender: newUser)
    }
    
    
    // KEYBOARD OVERLAPS VIEW
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 && (emailField.isFirstResponder || passwordField.isFirstResponder) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
    
    // DATEPICKER
    @objc func datePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        birthdateField.text = dateFormatter.string(from: datePicker.date)
        birthdateField.becomeFirstResponder()
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthdateField.inputView = datePicker
        birthdateField.inputAccessoryView = createToolbar()
        
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePressed))
        toolbar.setItems([button], animated: true)
        
        return toolbar
        
    }
    
    
    
    
    //DATATANSFER
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! UserViewController
//        let user = sender as! User
//        destinationVC.user = user
//    }
    
}

   // TEXTFIELDS

   extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            genderField.becomeFirstResponder()
        default: self.view.endEditing(true)
        }
        return true
    }
}
    
   // PICKERS

   extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case genderPicker:
            return genders.count
        default: return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case genderPicker:
            return genders[row]
        default: return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case genderPicker:
            genderField.text = genders[row]
        default: print("Picker nicht bekannt")
        }
        birthdateField.becomeFirstResponder()
    }
}
        

