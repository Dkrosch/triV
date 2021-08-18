//
//  GetData.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import Foundation

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
            StoreDataAuth.CreateData(username: txtFieldUsername.text!, email: txtFieldEmail.text!, DoB: txtFieldBirthday.text!, password: txtFieldPassword.text!, gender: txtFieldGender.text!) { status in
                if status {
                    self.performSegue(withIdentifier: "CreateProfile", sender: self)
                }else if status == false{
                    self.alert(msg: "Email has been registered")
                }
            }
        }
    }
}
