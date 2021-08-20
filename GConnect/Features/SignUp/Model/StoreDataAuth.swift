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
                           gender: String, game: String, role: String, rank: String, gamerUname: String){
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if error != nil{
                print(error)
            }else{
                var convertGender = ""
                if gender == "♂️Male"{
                    convertGender = "Male"
                }else{
                    convertGender = "Female"
                }
                
                let gender = convertGender
                let username = username
                let usrID = result!.user.uid
                
                self.saveUserDetail(userID: usrID, dob: DoB, gender: gender, username: username, game: game, role: role, rank: rank, gamerUname: gamerUname)
            }
        })
    }
    
    static func saveUserDetail(userID: String,
                               dob: String,
                               gender: String,
                               username: String, game: String, role: String, rank: String, gamerUname: String){
        let db = Firestore.firestore()

        db.collection("users").document(userID).setData(["gender": gender, "birthday": dob, "username": username, "About": "", "id": userID, "imageProfile": "", "imageRank": ""]) {(error) in
            if error != nil{
                print("Gagal")
            } else {
                print("Sukses")
            }
        }
        
        db.collection("users").document(userID).updateData(["game": game, "role" : role , "rank" : rank, "gamerUname": gamerUname]) {(error) in
            if error != nil{
                print("Gagal")
            } else {
                print("Sukses")
            }
        }
    }
}
