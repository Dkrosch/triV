//
//  GetData.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import Foundation
import Firebase

extension SignUpViewController{
    
    func getDatas(){
        if (txtFieldUsername.text == ""  || txtFieldGender.text == "" || txtFieldEmail.text == "" || txtFieldBirthday.text == "" || txtFieldPassword.text == "" || txtFieldConPassword.text == ""){
            alert(msg: "You need to fill all field")
        }else if (txtFieldEmail.text?.isValidEmail == false) {
            alert(msg: "Wrong Email Format")
        }else if (txtFieldPassword.text != txtFieldConPassword.text){
            alert(msg: "Password is not same")
        }else if txtFieldPassword.text!.count < 6{
            alert(msg: "Password must be 6 characters or more")
        }else{
            Auth.auth().fetchSignInMethods(forEmail: txtFieldEmail.text ?? "") { providers, error in
                if providers == nil{
                    self.goToChooseGame(username: self.txtFieldUsername.text!, email: self.txtFieldEmail.text!, dob: self.txtFieldBirthday.text!, password: self.txtFieldPassword.text!, gender: self.txtFieldGender.text!)
                } else {
                    self.alert(msg: "Email has been registered")
                }
            }
        }
    }
    
    func goToChooseGame(username: String, email: String, dob: String, password: String, gender: String){
        let showProfile = UIStoryboard(name: "Choose game detail", bundle: nil)
        let vc = showProfile.instantiateViewController(identifier: "CreateGame") as! ChooseGameViewController
        vc.username = username
        vc.email = email
        vc.dob = dob
        vc.password = password
        vc.gender = gender
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
