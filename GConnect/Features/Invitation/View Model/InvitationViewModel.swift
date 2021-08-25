//
//  InvitationViewModel.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 24/08/21.
//

import Foundation
import Firebase

class InvitationViewModel {
    
    var dataOwnLounge = [DetailLounge]()
    var currentUser = Auth.auth().currentUser?.uid
    
    func getDataOwnLounge(completion: @escaping ([DetailLounge]) -> Void){
        Firestore.firestore().collection("LoungeDetail").whereField("idMemberLounge.Member1", isEqualTo: currentUser as Any).getDocuments { (snapshots, error) in
            if error != nil {
                print(error as Any)
            }else {
                for documents in (snapshots?.documents)!{
                    let data = documents.data()
                    let creatAt = data["CreatAt"] as? String ?? ""
                    let desc = data["Desc"] as? String ?? ""
                    let game = data["Game"] as? String ?? ""
                    let judul = data["Title"] as? String ?? ""
                    
                    let idMemberLounge = data["idMemberLounge"] as? [String: Any]
                    let member1 = idMemberLounge!["Member1"] as? String
                    let member2 = idMemberLounge!["Member2"] as? String
                    let member3 = idMemberLounge!["Member3"] as? String
                    let member4 = idMemberLounge!["Member4"] as? String
                    let member5 = idMemberLounge!["Member5"] as? String
                    let member6 = idMemberLounge!["Member6"] as? String
                    let member7 = idMemberLounge!["Member7"] as? String
                    let member8 = idMemberLounge!["Member8"] as? String
                    let member9 = idMemberLounge!["Member9"] as? String
                    let member10 = idMemberLounge!["Member10"] as? String
                    
                    let idRequirementsLounge = data["idRequirementsLounge"] as? [String: Any]
                    let role1 = idRequirementsLounge!["Sentinel"] as? Bool
                    let role2 = idRequirementsLounge!["Initiator"] as? Bool
                    let role3 = idRequirementsLounge!["Controller"] as? Bool
                    let role4 = idRequirementsLounge!["Duelist"] as? Bool
                    
                    let gender = data["Gender"] as? String ?? ""
                    let rank = data["Rank"] as? String ?? ""
                    let documentId = documents.documentID

                    let newData = DetailLounge(game: game,title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt, gender: gender, rank: rank)
                    
                    self.dataOwnLounge.append(newData)
                }
            }
            DispatchQueue.main.async {
                completion(self.dataOwnLounge)
            }
        }
    }
    
    func validateLounge(dataLounge: [DetailLounge], idTargetedUser: String) -> ([DetailLounge]){
        
        var filteredDataLounge = [DetailLounge]()
        filteredDataLounge.removeAll()
        
        for (index, _) in dataLounge.enumerated(){
            if !dataLounge[index].idMemberLounge.contains(idTargetedUser){
                filteredDataLounge.append(dataLounge[index])
            }
        }
        
        return filteredDataLounge
    }
}

