//
//  StoreDataAuth.swift
//  GConnect
//
//  Created by Dion Lamilga on 28/07/21.
//

import UIKit
import Firebase
import FirebaseAuth


class StoreDataAuth {
    
    //ini escaping di pake buat closure jadi bisa buat balikin result dari fungsi ke halaman yang manggil
    static func CreateData(username: String,
                           email: String,
                           DoB: String,
                           password: String,
                           gender: String,
                           succcesCompletionHandler: @escaping (Bool) -> Void){
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            
            guard error == nil else{
                return
            }
            
            let Dob = DoB
            let gender = gender
            let username = username
            let usrID = result!.user.uid
            
            self.saveUserDetail(userID: usrID, dob: DoB, gender: gender, username: username) { status in
                
                //ini panggil untuk balikin ke halaman yang manggil fungsi CreateData
                succcesCompletionHandler(status)
            }
            
            print("Sukses register")
        })
    }
    
    static func saveUserDetail(userID: String,
                               dob: String,
                               gender: String,
                               username: String,
                               successCompletion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).setData(["gender": gender, "birthday": dob, "username": username, "HariIbu": "Besok"]) {(error) in
            if error != nil{
                successCompletion(false)
            } else {
                successCompletion(true)
                print("Sukses")
            }
        }
    }
    
}
