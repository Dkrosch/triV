//
//  LoginViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 27/07/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var wrongLabel: UILabel!
    
    var bottomLine = CALayer()
    var status = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameField.addBottomBorder()
        self.passwordField.addBottomBorder()
        
        usernameField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        wrongLabel.isHidden = true
        
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if usernameField.isEditing == true{
            let currectText = textField.text ?? ""
            guard let stringRange = Range(range, in: currectText) else {
                return false
            }
            
            let updateText = currectText.replacingCharacters(in: stringRange, with: string)
            
            return updateText.count < 21
        } else {
            let currectText = textField.text ?? ""
            guard let stringRange = Range(range, in: currectText) else {
                return false
            }
            
            let updateText = currectText.replacingCharacters(in: stringRange, with: string)
            
            return updateText.count < 17
        }
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
        if (usernameField.text == "" || passwordField.text == ""){
            wrongLabel.isHidden = true
        } else {
            AuthLogin.SignIn(email: usernameField.text!, password: passwordField.text!, status: status)
            
            if status == true{
                wrongLabel.isHidden = false
            }else{
                wrongLabel.isHidden = true
            }
        }
    }
}
