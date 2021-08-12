//
//  DetailLoungeViewModel.swift
//  GConnect
//
//  Created by Michael Tanakoman on 02/08/21.
//

import UIKit
import Firebase

class DetailLoungeViewModel {
    
    let db = Firestore.firestore()
    
    public func getData(id: String, escapingData: @escaping ([DetailLounge]) -> Void){
        
        let data = Firestore.firestore()
        let reference = data.collection("LoungeDetail").document(id)
        
        reference.getDocument { snapshot, error in
            if let err = error{
                print(err)
            }else if let snapshot = snapshot, snapshot.exists{
                let game = snapshot.get("Game") as? String
                let judul = snapshot.get("Title")as? String
                let desc = snapshot.get("Desc") as? String
                let gender = snapshot.get("Gender") as? String
                let rank = snapshot.get("Rank") as? String
                let creatAt = snapshot.get("CreateAt") as? String
                let idMemberLounge = snapshot.get("idMemberLounge") as! [String:Any]
                let idRequirementsLounge = snapshot.get("idRequirementsLounge") as! [String:Any]
                
                guard let member1 = idMemberLounge["Member1"] as? String else { return }
                guard let member2 = idMemberLounge["Member2"] as? String else { return }
                guard let member3 = idMemberLounge["Member3"] as? String else { return }
                guard let member4 = idMemberLounge["Member4"] as? String else { return }
                guard let member5 = idMemberLounge["Member5"] as? String else { return }
                guard let member6 = idMemberLounge["Member6"] as? String else { return }
                guard let member7 = idMemberLounge["Member7"] as? String else { return }
                guard let member8 = idMemberLounge["Member8"] as? String else { return }
                guard let member9 = idMemberLounge["Member9"] as? String else { return }
                guard let member10 = idMemberLounge["Member10"] as? String else { return }

                guard let role1 = idRequirementsLounge["Controller"] as? Bool else { return }
                guard let role2 = idRequirementsLounge["Duelist"] as? Bool else { return }
                guard let role3 = idRequirementsLounge["Initiator"] as? Bool else { return }
                guard let role4 = idRequirementsLounge["Sentinel"] as? Bool else { return }

                let newData = DetailLounge(game: game!,title: judul!, desc: desc!, idMemberLounge: [member1, member2, member3, member4, member5, member6, member7, member8, member9, member10], idRequirementsLounge: [role1, role2, role3, role4], documentId: id, creatAt: creatAt!, gender: gender!, rank: rank!)
                
                DispatchQueue.main.async {
                    escapingData([newData])
                }
            }
        }
    }
    
    public func getDataMember(idMember: [String], dataMember: @escaping ([LoungeMember]) -> Void){
        var datasMember = [LoungeMember]()
        let data = Firestore.firestore()
        let reference = data.collection("users")
        var arrayMember: [String] = []
        
        for idMemberlah in idMember{
            if idMemberlah != ""{
                arrayMember.append(idMemberlah)
            }
        }
        
        for (index, _) in arrayMember.enumerated(){
            DispatchQueue.global().sync {
                reference.document(arrayMember[index]).getDocument { document, error in
                    if error != nil{
                        print(error!)
                    }else if let document = document, document.exists {
                        let name = document.get("username") as! String
                        let role = document.get("role") as! String
                        let rank = document.get("rank") as! String
                        let imageProfile = document.get("imageProfile") as! String
                        let dataMemberLounge = LoungeMember(idMember: arrayMember[index], name: name, rank: rank, imageProfile: imageProfile, role: role)
                        
                        datasMember.append(dataMemberLounge)
                        print(dataMemberLounge.idMember)
                        
                    
                        if datasMember.count == arrayMember.count {
                            dataMember(datasMember)
                        }
                    }
                }
            }
        }
    }
    
    func updateDataLounge(idLounge: String, desc: String, rank: String, role: [Bool], gender: String){
        
        
        db.collection("LoungeDetail").document(idLounge).updateData(["Desc": desc, "Rank": rank, "idRequirementsLounge.Controller": role[0],"idRequirementsLounge.Duelist": role[1], "idRequirementsLounge.Initiator": role[2],"idRequirementsLounge.Sentinel": role[3], "Gender": gender]){ (error) in
                if error != nil {
                    print (error as Any)
                }else{
                    print("sukses")
                }
        }
    }
    
    func insertMember(idMember: String, idLounge: String, unfillMember: String){
        db.collection("LoungeDetail").document(idLounge).updateData(["idMemberLounge.\(unfillMember)":idMember]){ error in
            if error != nil {
                print (error as Any)
            }else{
                print("sukses")
            }
        }
    }
    
    func deleteLounge(idLounge: String){
        db.collection("LoungeDetail").document(idLounge).delete(){ error in
            if error != nil{
                print("eror")
            } else{
                print("done")
            }
        }
    }
    
    func leaveLounge(idLounge: String, filledCurrentMember: String){
        db.collection("LoungeDetail").document(idLounge).updateData(["idMemberLounge.\(filledCurrentMember)": ""]) { error in
            if error != nil {
                print (error as Any)
            }else{
                print("sukses")
            }
        }
    }
}
