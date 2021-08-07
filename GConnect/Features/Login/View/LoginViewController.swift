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
        
        wrongLabel.isHidden = true
        
        loginBtn.layer.cornerRadius = 10
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if usernameField.isEditing == true{
            let currectText = textField.text ?? ""
            guard let stringRange = Range(range, in: currectText) else {
                return false
            }
            
            let updateText = currectText.replacingCharacters(in: stringRange, with: string)
            
            return updateText.count < 35
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
            AuthLogin.SignIn(email: usernameField.text!, password: passwordField.text!){ status in
                if status{
                    self.performSegue(withIdentifier: "LoginToExploreLounge", sender: self)
                    self.wrongLabel.isHidden = true
                }else{
                    self.wrongLabel.isHidden = false
                    Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector (self.hideWrongLabel), userInfo: nil, repeats: false)
                }
            }
        }
    }
    
    @objc func hideWrongLabel(){
        self.wrongLabel.isHidden = true
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
}
