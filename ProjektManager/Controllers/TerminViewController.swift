//
//  TerminViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 13.01.23.
//

import UIKit


class TerminViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var termine = [Termine]()
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    @IBOutlet weak var termin1: UILabel!
    @IBOutlet weak var termin2: UILabel!
    @IBOutlet weak var termin3: UILabel!
    
    //    let dateTimePicker = UIDatePicker()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        createTimePicker()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        fetchTermine()
    }
    func fetchTermine() {
        
        //Termine laden
        
        termin1.text = eingeloggterUser!.termin1
        termin2.text = eingeloggterUser!.termin2
        termin3.text = eingeloggterUser!.termin3
        
    }
    
    
    
    func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateField.inputView = datePicker
        dateField.inputAccessoryView = createDateToolbar()
        
    }
    
    func createTimePicker(){
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "de")
        timeField.inputView = timePicker
        timeField.inputAccessoryView = createTimeToolbar()
        
    }
    
    
    
    func createDateToolbar()-> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createTimeToolbar()-> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePressed))
        toolbar.setItems([doneButton], animated: true)
        
        
        
        return toolbar
    }
    
    @objc func datePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MMMM.yyyy"
        dateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func timePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeField.text = dateFormatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func createTermin() {
        // bestimme mit der varible time das es ein string ist
        //        let newUser = User(context: self.context)
        //        newUser.name = nameField.text
        //        newUser.gender = genderField.text
        //        let dateFormater = DateFormatter()
        //        newUser.birthdate = dateFormater.date(from: birthdateField.text!)
        //        newUser.password = passwordField.text
        //        newUser.email = emailField.text
        //        newUser.firma = firmaField.text
        
        
        let date: String = dateField.text ?? ""
        let time: String = timeField.text ?? ""
        let neuerTermin = date + " " + time
        if termin1.text == "" {
            print(1)
            termin1.text = neuerTermin
            
        }else if termin2.text == "" {
            print(2)
            termin2.text = neuerTermin
            
        }else if termin3.text == "" {
            print(3)
            termin3.text = neuerTermin
            
        }else {
            print(4)
            termin1.text = termin2.text
            termin2.text = termin3.text
            termin3.text = neuerTermin
            
        }
        eingeloggterUser!.termin1 = termin1.text
        eingeloggterUser!.termin2 = termin2.text
        eingeloggterUser!.termin3 = termin3.text
        //       speicher termin 123 ab
        do{
            try self.context.save()
        }catch{
            print("creation failed")
        }
        
        
    }
    
    
    
}
