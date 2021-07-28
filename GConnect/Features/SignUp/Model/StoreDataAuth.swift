//
//  StoreDataAuth.swift
//  GConnect
//
//  Created by Dion Lamilga on 28/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class StoreDataAuth{
    static func CreatData(username: String, email: String, DoB: String, password: String, gender: String){
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            
            guard error == nil else{
                print("Fails")
                return
            }
            
            let Dob = DoB
            let gender = gender
            let username = username
            
            let db = Firestore.firestore()
            
            db.collection("users").addDocument(data: ["gender": gender, "birthday": Dob, "username": username, "uid": result!.user.uid]) { (error)  in
                
                if error != nil{
                    print("error")
                }
            }
            
            print("Sukses register")
        })
    }
    
}
