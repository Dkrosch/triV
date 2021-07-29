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
                
                return
            }
            
            let Dob = DoB
            let gender = gender
            let username = username
            
            let usrID = result!.user.uid
            self.saveUserDetail(userID: usrID, dob: Dob, gender: gender, username: username)
            
//            db.collection("users").addDocument(data: ["gender": gender, "birthday": Dob, "username": username, "uid": result!.user.uid]) { (error)  in
//
//                if error != nil{
//                    print("error")
//                }
//            }
            
            print("Sukses register")
        })
    }
    
    static func saveUserDetail(userID: String, dob: String, gender: String, username: String){
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).setData(["gender": gender, "birthday": dob, "username": username, "HariIbu": "Besok"]) {(error) in
            if error != nil{
                print("Fail")
            } else {
                print("Sukses")
            }
        }
    }
    
}
