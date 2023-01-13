//
//  TerminViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 13.01.23.
//

import UIKit


class TerminViewController: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
//    let dateTimePicker = UIDatePicker()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        createTimePicker()
        
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
    
    @IBAction func createTermin() {}
  
    
    
}
