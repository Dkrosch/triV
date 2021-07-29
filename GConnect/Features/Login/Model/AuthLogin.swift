//
//  AuthLogin.swift
//  GConnect
//
//  Created by Dion Lamilga on 28/07/21.
//

import UIKit
import FirebaseAuth

class AuthLogin{
    
    static func SignIn(email: String, password: String, status: Bool){
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            var Status = status
            
            guard error == nil else{
                print("Salah")
                Status = false
                return
            }
            
            Status = false
            print("SignIn")
        })
    }

}
