//
//  InvitationListViewModel.swift
//  GConnect
//
//  Created by Michael Tanakoman on 25/08/21.
//

import Firebase
import UIKit

class InvitationListViewModel{
    let myGroup = DispatchGroup()
    
    func getDataInvite(completion: @escaping ([GetDataInvitePeople]) -> Void){
        
        let currentUser = Auth.auth().currentUser?.uid
        var dataInvite = [GetDataInvitePeople]()
        
        Firestore.firestore().collection("InvitationList").whereField("idInvitedUser", isEqualTo: currentUser as Any).getDocuments { snapshot, error in
            if error != nil {
                print(error as Any)
            }else{
                for document in (snapshot?.documents)!{
                    let data = document.data()
                    let idInvite = document.documentID
                    let idLounge = data["idLounge"] as? String ?? ""
                    let idMaster = data["idMaster"] as? String ?? ""
                    let idInvitedUser = data["idInvitedUser"] as? String ?? ""
                    let newData = GetDataInvitePeople(idLounge: idLounge, idInvitedUser: idInvitedUser, idMaster: idMaster, idInvite: idInvite)
                    dataInvite.append(newData)
                }
            }
            DispatchQueue.main.async {
                completion(dataInvite)
            }
        }
    }
    
    func getDataLoungeUser (dataInvite: [GetDataInvitePeople], completion: @escaping ([GetDataLoungeUser]) -> Void){
        
        var dataLoungeUser = [GetDataLoungeUser]()
        
        for (index, _) in dataInvite.enumerated(){
            myGroup.enter()
            var username: String?
            var role: String?
            var fixIdMemberLounge: [String]?
            var fixRequirements: [Bool]?
            var descLounge: String?
            var idLounge: String?
            var idInvite: String?
            var titleLounge: String?
            var rank: String?
            
            Firestore.firestore().collection("LoungeDetail").document(dataInvite[index].idLounge).getDocument { snapshot, error in
                if error != nil{
                    print(error as Any)
                }else if let snapshot = snapshot, snapshot.exists{
                    let idMemberLounge = snapshot.get("idMemberLounge") as! [String:Any]
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
                    fixIdMemberLounge = [member1, member2, member3, member4, member5, member6, member7, member8, member9, member10]
                    
                    let idRequirementsLounge = snapshot.get("idRequirementsLounge") as! [String:Any]
                    guard let role1 = idRequirementsLounge["Controller"] as? Bool else { return }
                    guard let role2 = idRequirementsLounge["Duelist"] as? Bool else { return }
                    guard let role3 = idRequirementsLounge["Initiator"] as? Bool else { return }
                    guard let role4 = idRequirementsLounge["Sentinel"] as? Bool else { return }
                    fixRequirements = [role1, role2, role3, role4]
                    descLounge = snapshot.get("Desc") as? String ?? ""
                    titleLounge = snapshot.get("Title") as? String ?? ""
                    rank = snapshot.get("Rank") as? String ?? ""
                    idLounge = dataInvite[index].idLounge
                    idInvite = dataInvite[index].idInvite
                    
                    Firestore.firestore().collection("users").document(dataInvite[index].idMaster).getDocument { snapshot, error in
                        if error != nil{
                            print(error as Any)
                        }else if let document = snapshot, document.exists{
                            username = document.get("username") as? String ?? ""
                            role = document.get("role") as? String ?? ""
                            self.myGroup.leave()
                        }
                    }
                }
            }
            myGroup.notify(queue: .main){
                self.myGroup.enter()
                dataLoungeUser.append(GetDataLoungeUser(username: username ?? "", role: role ?? "", idMemberLounge: fixIdMemberLounge ?? [""], idRequirementsLounge: fixRequirements ?? [false], descLounge: descLounge ?? "", idLounge: idLounge ?? "", idInvite: idInvite ?? "", titleLounge: titleLounge ?? "", rank: rank ?? ""))
                self.myGroup.leave()
            }
        }
        
        myGroup.notify(queue: .main){
            completion(dataLoungeUser)
        }
    }
    
    func acceptInvitation(idLounge: String, idInvitation: String){
        var arrayMember: [String]?
        var unfillMember = ""
        
        Firestore.firestore().collection("LoungeDetail").document(idLounge).getDocument { snapshot, error in
            if error != nil{
                print(error as Any)
            }else if let snapshot = snapshot, snapshot.exists{
                let idMemberLounge = snapshot.get("idMemberLounge") as? [String:Any]
                let member1 = idMemberLounge?["Member1"] as? String ?? ""
                let member2 = idMemberLounge?["Member2"] as? String ?? ""
                let member3 = idMemberLounge?["Member3"] as? String ?? ""
                let member4 = idMemberLounge?["Member4"] as? String ?? ""
                let member5 = idMemberLounge?["Member5"] as? String ?? ""
                let member6 = idMemberLounge?["Member6"] as? String ?? ""
                let member7 = idMemberLounge?["Member7"] as? String ?? ""
                let member8 = idMemberLounge?["Member8"] as? String ?? ""
                let member9 = idMemberLounge?["Member9"] as? String ?? ""
                let member10 = idMemberLounge?["Member10"] as? String ?? ""
                arrayMember = [member1, member2, member3, member4, member5, member6, member7, member8, member9, member10]
                
                if arrayMember?[1] == "" {unfillMember = "Member2"}
                else if arrayMember?[2] == "" {unfillMember = "Member3"}
                else if arrayMember?[3] == "" {unfillMember = "Member4"}
                else if arrayMember?[4] == "" {unfillMember = "Member5"}
                else if arrayMember?[5] == "" {unfillMember = "Member6"}
                else if arrayMember?[6] == "" {unfillMember = "Member7"}
                else if arrayMember?[7] == "" {unfillMember = "Member8"}
                else if arrayMember?[8] == "" {unfillMember = "Member9"}
                else if arrayMember?[9] == "" {unfillMember = "Member10"}
                
                if unfillMember == ""{
                    self.deleteInvitation(idInvitation: idInvitation)
                    
                    let msg = MessageInvite(title: "Error", msg: "Lounge already full", txtButton: "OK")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "showAlert"), object: msg)
                }else if (arrayMember?.contains(Auth.auth().currentUser?.uid ?? "") == true){
                    self.deleteInvitation(idInvitation: idInvitation)
                    
                    let msg = MessageInvite(title: "Error", msg: "You already joined this lounge before", txtButton: "OK")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "showAlert"), object: msg)
                }else{
                    self.deleteInvitation(idInvitation: idInvitation)
                    self.insertMember(idMember: Auth.auth().currentUser?.uid ?? "", idLounge: idLounge, unfillMember: unfillMember)
                    
                    let msg = MessageInvite(title: "Success", msg: "You joined this lounge", txtButton: "OK")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "showAlert"), object: msg)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshCollectionView"), object: nil)
                }
            }
        }
    }
    
    func deleteInvitation(idInvitation: String){
        Firestore.firestore().collection("InvitationList").document(idInvitation).delete(){ error in
            if error != nil{
                print(error as Any)
            }else{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshCollectionView"), object: nil)
            }
        }
    }
    
    func insertMember(idMember: String, idLounge: String, unfillMember: String){
        Firestore.firestore().collection("LoungeDetail").document(idLounge).updateData(["idMemberLounge.\(unfillMember)":idMember]){ error in
            if error != nil {
                print (error as Any)
            }else{
                print("sukses")
            }
        }
    }
}
