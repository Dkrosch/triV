//
//  TestingSBViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 27/08/21.
//

import UIKit

class TestingSBViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignin: UIButton!
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogin.layer.cornerRadius = 10
        btnSignin.layer.cornerRadius = 10
    }
    
    
    @IBAction func LoginTapped(_ sender: Any) {
        let backLogin = UIStoryboard(name: "Login", bundle: nil)
        let vc = backLogin.instantiateViewController(identifier: "loginView") as! UINavigationController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        defaults.set(true, forKey: "first")
        self.present(vc, animated: true)
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        let SignUpSB = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = SignUpSB.instantiateViewController(identifier: "signUp") as! SignUpViewController
        vc.modalPresentationStyle = .overFullScreen
        defaults.set(true, forKey: "first")
        self.present(vc, animated: true)
    }
    
}
