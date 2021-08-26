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
                for (index, _) in dataInvite.enumerated(){
                    print(dataInvite[index].idInvitedUser, dataInvite[index].idLounge, dataInvite[index].idMaster)
                }
                completion(dataInvite)
            }
        }
    }
    
    func getDataLounge(dataInvite: [GetDataInvitePeople], completion: @escaping ([DetailLounge]) -> Void){
        
        var dataLounge = [DetailLounge]()
        for (index, _) in dataInvite.enumerated(){
            myGroup.enter()
            Firestore.firestore().collection("LoungeDetail").document(dataInvite[index].idLounge).getDocument { snapshot, error in
                if error != nil{
                    print(error as Any)
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

                    let newData = DetailLounge(game: game!,title: judul!, desc: desc!, idMemberLounge: [member1, member2, member3, member4, member5, member6, member7, member8, member9, member10], idRequirementsLounge: [role1, role2, role3, role4], documentId: dataInvite[index].idLounge, creatAt: creatAt!, gender: gender!, rank: rank!)
                    dataLounge.append(newData)
                    self.myGroup.leave()
                }
            }
        }
        myGroup.notify(queue: .main){
            for (index, _) in dataLounge.enumerated(){
                print(dataLounge[index].documentId, dataLounge[index].title)
            }
            completion(dataLounge)
        }
    }
    
    func getDataUser(dataInvite: [GetDataInvitePeople], completion: @escaping ([ProfileData]) -> Void){
        var dataUser = [ProfileData]()
        
        for (index, _) in dataInvite.enumerated(){
            myGroup.enter()
            Firestore.firestore().collection("users").document(dataInvite[index].idMaster).getDocument { snapshot, error in
                if error != nil{
                    print(error as Any)
                }else if let document = snapshot, document.exists{
                    let username = document.get("username") as! String
                    let gender = document.get("gender") as! String
                    let about = document.get("About") as! String
                    let imageProfile = document.get("imageProfile") as! String
                    let role = document.get("role") as! String
                    let rank = document.get("rank") as! String
                    let game = document.get("game") as! String
                    let birthday = document.get("birthday") as! String
                    let gamerUname = document.get("gamerUname") as! String

                    let newData = ProfileData(username: username, game: game, gender: gender, rank: rank, role: role, birthday: birthday, imageProfile: imageProfile, desc: about, gamerUname: gamerUname)
                    dataUser.append(newData)
                    self.myGroup.leave()
                }
            }
        }
        myGroup.notify(queue: .main){
            for (index, _) in dataUser.enumerated(){
                print(dataUser[index].username)
            }
            completion(dataUser)
        }
    }
    
    func acceptInvitation(idLounge: String){
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
                    print("lounge full")
                }else{
                    self.insertMember(idMember: Auth.auth().currentUser?.uid ?? "", idLounge: idLounge, unfillMember: unfillMember)
                }
            }
        }
    }
    
    func deleteInvitation(idInvitation: String){
        print(idInvitation)
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
