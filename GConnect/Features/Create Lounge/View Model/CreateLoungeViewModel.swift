//
//  CreateLoungeViewModel.swift
//  GConnect
//
//  Created by Michael Tanakoman on 30/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateLoungeViewModel{
    var checkRole = [false, false, false, false]
    
    func createLoungeData(game: String, title: String, role: [Bool], rank: String, gender: String, desc: String, uid: String, valid: @escaping (String) -> Void){
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        formatter.dateStyle = .long
        let currentTime = formatter.string(from: currentDateTime)
        
        let db = Firestore.firestore().collection("LoungeDetail").document()
        let idLounge = db.documentID
        
        if game == ""{
            valid("game")
        }else if title == ""{
            valid("title")
        }else if role == checkRole{
            valid("role")
        }else{
            db.setData(["CreateAt":currentTime, "Desc":desc, "Game":game, "Title":title, "idMemberLounge":["Member1":uid, "Member2":"", "Member3":"", "Member4":"", "Member5":"", "Member6":"", "Member7":"", "Member8":"", "Member9":"", "Member10":""], "idRequirementsLounge":["Sentinel":role[0], "Initiator":role[1], "Controller":role[2], "Duelist":role[3], ], "Gender":gender, "Rank":rank]) {(error) in
                if error != nil{
                    print("Gagal")
                } else {
                    print("Sukses create lounge")
                }
            }
            
            Firestore.firestore().collection("LoungeDetail").document(idLounge).collection("thread").document().collection("thread").document().setData(["content":"", "created":"", "id":"", "senderID":"", "senderName":""]){(error) in
                if error != nil{
                    print("Gagal")
                } else {
                    print("Sukses create chat lounge")
                }
            }
            
            valid("true")
        }
    }
}
