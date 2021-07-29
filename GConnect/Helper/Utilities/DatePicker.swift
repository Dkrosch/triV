//
//  DatePicker.swift
//  GConnect
//
//  Created by Michael Tanakoman on 28/07/21.
//

import UIKit

let datePicker = UIDatePicker()
var textfield: UITextField?

class DatePicker{
    func createDatepicker(textField: UITextField) {
        textfield = textField
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        textfield!.inputView = datePicker
        textfield!.inputAccessoryView = createToolbar()
    }
    
    func createToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem (barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        textfield?.text = dateFormatter.string(from: datePicker.date)
        textfield?.resignFirstResponder()
    }
}
