//
//  Datas.swift
//  GConnect
//
//  Created by Dion Lamilga on 16/08/21.
//

import Foundation
import Firebase

extension ExploreLoungeViewController{
    
    func getDatas(){
        
        if let savedFilter = UserDefaults.standard.object(forKey: "filterLounge") as? Data{
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(FilterLounge.self, from: savedFilter){
                filter = loadedFilter
            }
        }
        
        datas = []
        
        var reference: Query?
        
        if filter?.statusFilter == true {
            reference = Firestore.firestore().collection("LoungeDetail").whereField("idRequirementsLounge.Controller", isEqualTo: filter?.arrayRole[0] ?? "").whereField("idRequirementsLounge.Duelist", isEqualTo: filter?.arrayRole[1] ?? "").whereField("idRequirementsLounge.Initiator", isEqualTo: filter?.arrayRole[2] ?? "").whereField("idRequirementsLounge.Sentinel", isEqualTo: filter?.arrayRole[3] ?? "").whereField("Rank", isEqualTo: filter?.rank ?? "").whereField("Gender", isEqualTo: filter?.gender ?? "")
        } else if filter?.statusFilter == false{
            reference = Firestore.firestore().collection("LoungeDetail")
        }
        
        reference!.getDocuments { snapshot, error in
            if error != nil{
                print("error")
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
                    
                    self.datas.append(newData)
                }
                self.loungeCollectionView.reloadData()
            }
        }
        loungeCollectionView.reloadData()
    }
}
