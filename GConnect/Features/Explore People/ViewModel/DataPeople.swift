//
//  DataPeople.swift
//  GConnect
//
//  Created by Vincent on 19/08/21.
//

import Foundation
import Firebase

class DataPeople{
    func getData(dataUser: @escaping ([ProfileData]) -> Void){
        
        var userProfile = [ProfileData]()
        
        let reference = Firestore.firestore().collection("users")
        
        reference.getDocuments { snapshot, error in
            if error != nil{
                print("error")
            }else{
                for document in (snapshot?.documents)!{
                    DispatchQueue.global().sync {
                        let data = document.data()
                        let username = data["username"] as? String ?? ""
                        let role = data["role"] as? String ?? ""
                        let rank = data["rank"] as? String ?? ""
                        let imageProfile = data["imageProfile"] as? String ?? ""
                        let imageRank = data["imageRank"] as? String ?? ""
                        
                        let about = data["About"] as? String ?? ""
                        let birthday = data["birthday"] as? String ?? ""
                        let game = data["game"] as? String ?? ""
                        let gamerUname = data["gamerUname"] as? String ?? ""
                        let gender = data["gender"] as? String ?? ""
                        
                        let newData = ProfileData(username: username, game: game, gender: gender, rank: rank, role: role, birthday: birthday, imageProfile: imageProfile, desc: about, imageRank: imageRank, gamerUname: gamerUname)
                        
                        userProfile.append(newData)
                        
                        if userProfile.count != 0 {
                            dataUser(userProfile)
                        }
                    }
                }
            }
        }
    }
}
