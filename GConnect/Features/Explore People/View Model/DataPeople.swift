//
//  DataPeople.swift
//  GConnect
//
//  Created by Vincent on 20/08/21.
//

import Foundation
import Firebase

extension ExplorePeopleUIView{
    func getData(){
        
        if let savedFilter = UserDefaults.standard.object(forKey: "filterPeople") as? Data{
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(FilterPeople.self, from: savedFilter){
                filter = loadedFilter
            }
        }
        
        userProfile = []
        
        var reference: Query?
        
        if filter?.statusFilter == true{
            reference = Firestore.firestore().collection("users").whereField("role", in: [filter?.recon ?? "", filter?.offensive ?? "", filter?.defensive ?? "", filter?.support ?? ""]).whereField("rank", isEqualTo: filter?.rank ?? ""), 
        } else if filter?.statusFilter == false {
            reference = Firestore.firestore().collection("users")
        }
        
        reference!.getDocuments { snapshot, error in
            if error != nil{
                print("error")
            }else{
                for document in (snapshot?.documents)!{
                    DispatchQueue.global().sync {
                        let data = document.data()
                        let idUser = document.documentID
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
                        let level = data["level"] as? String ?? ""
                        let legend = data["legend"] as? String ?? ""
                        
                        let newData = ExplorePeople(username: username, game: game, gender: gender, rank: rank, role: role, birthday: birthday, imageProfile: imageProfile, desc: about, imageRank: imageRank, gamerUname: gamerUname, level: level, legend: legend, idUser: idUser)
                        
                        if idUser != Auth.auth().currentUser?.uid{
                            self.userProfile.append(newData)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.userCollectionView.reloadData()
                }
                self.userCollectionView.reloadData()
            }
        }
        userCollectionView.reloadData()
    }
}
