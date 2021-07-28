//
//  SignUpViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 27/07/21.
//

import UIKit


class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldBirthday: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldConPassword: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    
    let gender = ["Male", "Female"]
    var pickerView = UIPickerView()
    var bottomLine = CALayer()
    public var username:String?
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtFieldUsername.addBottomBorder()
        self.txtFieldEmail.addBottomBorder()
        self.txtFieldBirthday.addBottomBorder()
        self.txtFieldPassword.addBottomBorder()
        self.txtFieldConPassword.addBottomBorder()
        self.hideKeyboardWhenTappedAround()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtFieldEmail.keyboardType = .emailAddress
        
        txtFieldUsername.delegate = self
        
        createDatepicker()
        
        txtFieldGender.inputView = pickerView
        txtFieldGender.text = "Male"
        txtFieldGender.setLeftPaddingPoints(10)
        
        //signUpModelView.cobaTarikData()
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
//        signUpModelView.btnSignUpTapped(username: txtFieldUsername.text!, email: txtFieldEmail.text!, birthday: txtFieldBirthday.text!, gender: txtFieldGender.text! ,password: txtFieldPassword.text!, conPassword: txtFieldConPassword.text!)
        
        StoreDataAuth.CreatData(username: txtFieldUsername.text!, email: txtFieldEmail.text!, DoB: txtFieldBirthday.text!, password: txtFieldPassword.text!, gender: txtFieldGender.text!)
        
        showloginPage()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func createDatepicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        txtFieldBirthday.inputView = datePicker
        txtFieldBirthday.inputAccessoryView = createToolbar()
    }
    
    func createToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem (barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.txtFieldBirthday.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        txtFieldBirthday.text = dateFormatter.string(from: datePicker.date)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
}

extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFieldGender.text = gender[row]
        txtFieldGender.resignFirstResponder()
    }
    
    func showloginPage(){
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = loginStoryboard.instantiateViewController(identifier: "login") as! LoginViewController
        self.present(vc, animated: true)
    }

}
