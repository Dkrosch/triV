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
                var signUpViewController = SignUpViewController()

                //ini panggil untuk balikin ke halaman yang manggil fungsi CreateData
                succcesCompletionHandler(false)
                print("Email sudah kepake")
                
                return
            }
            succcesCompletionHandler(true)
            
            var convertGender = ""
            if gender == "♂️Male"{
                convertGender = "Male"
            }else{
                convertGender = "Female"
            }
            
            let Dob = DoB
            let gender = convertGender
            let username = username
            let usrID = result!.user.uid
            
            self.saveUserDetail(userID: usrID, dob: DoB, gender: gender, username: username)
                
            print("Sukses register")
        })
    }
    
    static func saveUserDetail(userID: String,
                               dob: String,
                               gender: String,
                               username: String){
        let db = Firestore.firestore()
        
                    //nama tabel    mau rubah/input di user mana
        db.collection("users").document(userID).setData(["gender": gender, "birthday": dob, "username": username, "About": "", "id": userID, "imageProfile": "", "imageRank": ""]) {(error) in
            if error != nil{
                print("Gagal")
            } else {
                print("Sukses")
            }
        }
    }
}
