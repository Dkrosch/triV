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
    @IBOutlet weak var txtErrorMessage: UILabel!
    
    let gender = ["♂️Male", "♀ Female"]
    var pickerView = UIPickerView()
    var bottomLine = CALayer()
    public var username:String?
    var datePicker = DatePicker()
    var imageView = UIImageView()
    var image = UIImage(named: "Upload_icon.svg")
    var signUpSuccess: Bool = false
    
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
        
        imageView.image = image
        txtFieldGender.leftView = imageView
        txtFieldGender.leftViewMode = .always
        
        txtFieldUsername.delegate = self
        
        datePicker.createDatepicker(textField: txtFieldBirthday)
        
        txtFieldGender.inputView = pickerView
        txtFieldGender.text = "♂️Male"
        txtFieldGender.setLeftPaddingPoints(10)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        if (txtFieldUsername.text == ""  || txtFieldGender.text == "" || txtFieldEmail.text == "" || txtFieldBirthday.text == "" || txtFieldPassword.text == "" || txtFieldConPassword.text == ""){
            alert(msg: "You need to fill all field")
        }else if (txtFieldEmail.text?.isValidEmail == false) {
            alert(msg: "Wrong Email Format")
        }else if (txtFieldPassword.text != txtFieldConPassword.text){
            alert(msg: "Password is not same")
        }else if txtFieldPassword.text!.count < 6{
            alert(msg: "Password must be 6 characters or more")
        }else{
            StoreDataAuth.CreateData(username: txtFieldUsername.text!, email: txtFieldEmail.text!, DoB: txtFieldBirthday.text!, password: txtFieldPassword.text!, gender: txtFieldGender.text!) { status in
                if status {
                    self.performSegue(withIdentifier: "CreateProfile", sender: self)
                }else if status == false{
                    self.alert(msg: "Email has been registered")
                }
            }
        }
    }
    
    func alert(msg: String){
        let alert = UIAlertController(title: "Warning", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
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
}
