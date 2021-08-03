//
//  DataUser.swift
//  GConnect
//
//  Created by Dion Lamilga on 02/08/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
//
//class DataUser{
//    
//    static func GetData(id: String, succcesCompletionHandler: @escaping ([ProfileData]) -> Void){
//        
//        var data = [ProfileData]()
//        
//        var collectionRef: CollectionReference
//        
//        collectionRef = Firestore.firestore().collection("user")
//        
//        collectionRef.whereField("id", isEqualTo: id).getDocuments{ snapshot, error in
//            if let err = error{
//                print(err)
//            }
//            else{
//                for document in (snapshot?.documents)!{
//                    let data = document.data()
//                    let username = data["username"] as? String ?? ""
//                    let about = data["About"] as? String ?? ""
//                    guard let game = data["game"] as? String else { return }
//                    let achivment = data["Achivment"] as? [String: Any]
//                    let image = achivment!["Image"] as? String
//                    let title = achivment!["Title"] as? String
//                    let deskripsi = achivment!["deskripsi"] as? String
//                    let gender = data["gender"] as? String ?? ""
//                    let rank = data["rank"] as? String ?? ""
//                    let role = data["role"] as? String ?? ""
//                    let birthday = data["birthday"] as? String ?? ""
//                    let imageProfile = data["imageProfile"] as? String ?? ""
//                    let imageRank = data["imageRank"] as? String ?? ""
//                    
//                    let newData = ProfileData(username: username, game: game, gender: gender, rank: rank, role: role, birthday: birthday, imageProfile: imageProfile, achivement: [title!, deskripsi!, image!], desc: about, imageRank: imageRank)
//                    
//                    succcesCompletionHandler([newData])
//                }
//            }
//            
//        }
//    }
//    
//}

