//
//  AuthLogin.swift
//  GConnect
//
//  Created by Dion Lamilga on 28/07/21.
//

import UIKit
import FirebaseAuth

class AuthLogin{
    
    static func SignIn(email: String, password: String){
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            
            guard error == nil else{
                print("Salah")
                return
            }
            
            print("SignIn")
        })
    }

}
