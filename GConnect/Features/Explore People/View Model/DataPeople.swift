//
//  DataPeople.swift
//  GConnect
//
//  Created by Vincent on 20/08/21.
//

import Foundation
import Firebase

extension ExplorePeopleUIView{
    func getData(completion: @escaping ([ExplorePeople]) -> Void){
        
        userProfile = []
        
        let reference = Firestore.firestore().collection("users")
        
        reference.getDocuments { snapshot, error in
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
                    completion(self.userProfile)
                }
            }
        }
        userCollectionView.reloadData()
    }
    
    func getDataSearch(dataUser: [ExplorePeople], searchText: String, completion: @escaping ([ExplorePeople]) -> Void){
        var searchData = [ExplorePeople]()
        
        if searchText == "" {
            return
        } else {
            for (index, _) in dataUser.enumerated() {
                let username = dataUser[index].username
                if username.localizedCaseInsensitiveContains(searchText){
                    let newData = ExplorePeople(username: username, game: dataUser[index].game, gender: dataUser[index].gender, rank: dataUser[index].rank, role: dataUser[index].role, birthday: dataUser[index].birthday, imageProfile: dataUser[index].imageProfile, desc: dataUser[index].desc, imageRank: dataUser[index].imageRank, gamerUname: dataUser[index].gamerUname, level: dataUser[index].level, legend: dataUser[index].legend, idUser: dataUser[index].idUser)
                    searchData.append(newData)
                }
            }
            
            DispatchQueue.main.async {
                completion(searchData)
            }
        }
    }
}
