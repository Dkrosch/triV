//
//  ChatListViewModel.swift
//  GConnect
//
//  Created by Michael Tanakoman on 07/08/21.
//

import UIKit
import Firebase

class ChatListViewModel{
    
    public func getDataLounge(escaping: @escaping ([DetailLounge]) -> Void){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let reference = Firestore.firestore()
        
        for i in 1...10{
            DispatchQueue.global().sync {
                reference.collection("LoungeDetail").whereField("idMemberLounge.Member\(i)", isEqualTo: userID).getDocuments { snapshot, error in
                    if let err = error{
                        print(err)
                    } else {
                        for document in (snapshot?.documents)!{
                            let data = document.data()
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
                            let documentId = document.documentID

                            let newData = DetailLounge(game: game,title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt, gender: gender, rank: rank)
                            
                            var datas = [DetailLounge]()
                            
                            datas.append(newData)
                            escaping(datas)
                        }
                    }
                }
            }
        }
    }
}
