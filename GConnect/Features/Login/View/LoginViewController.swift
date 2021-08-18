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
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongLabel.isHidden = true
        
        loginBtn.layer.cornerRadius = 10

        usernameField.delegate = self
        passwordField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = true
        
        if defaults.bool(forKey: "isUserSignedIn"){
            self.performSegue(withIdentifier: "LoginToExploreLounge", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logoImage.layer.cornerRadius = logoImage.frame.height/2
        self.usernameField.addBottomBorder()
        self.passwordField.addBottomBorder()
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
            return updateText.count < 20
        }
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
        if (usernameField.text == "" || passwordField.text == ""){
            let alert = UIAlertController(title: "Warning", message: "Insert your email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            AuthLogin.SignIn(email: usernameField.text!, password: passwordField.text!){ status in
                if status{
                    let dataFilter = FilterLounge(statusFilter: false,game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
                    let encoder = JSONEncoder()
                    if let filter = try? encoder.encode(dataFilter){
                        UserDefaults.standard.set(filter, forKey: "filterLounge")
                    }
                    self.defaults.set(true, forKey: "isUserSignedIn")
                    self.defaults.synchronize()
                    self.performSegue(withIdentifier: "LoginToExploreLounge", sender: self)
                    self.wrongLabel.isHidden = true
                }else{
                    let alert = UIAlertController(title: "Warning", message: "Incorrect email or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }

    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
}
