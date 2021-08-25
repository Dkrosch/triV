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
    
    func getDataChatRoom(data: @escaping ([PersonalChatRoom]) -> Void) {
        let myGroup = DispatchGroup()
        var dataUser: [PersonalChatRoom] = []
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        
        Firestore.firestore().collection("ChatPersonal").whereField("users", arrayContains: userID).getDocuments { snapshot, error in
            if error != nil {
                print(error as Any)
            }else{
                for document in (snapshot?.documents)!{
                    myGroup.enter()
                    let data = document.data()
                    let users = data["users"] as? [String] ?? [""]
                    let idPersonalChat = document.documentID
                    let newData = PersonalChatRoom(idPersonalChat: idPersonalChat, idUser: users)
                    dataUser.append(newData)
                    myGroup.leave()
                }
                myGroup.notify(queue: .main){
                    data(dataUser)
                }
            }
        }
    }
    
    func getDataUser(data: [PersonalChatRoom], completion: @escaping ([TargetedUser]) -> Void){
        let currentUserID = Auth.auth().currentUser?.uid ?? ""
        var arrayUser: [String] = []
        let myGroup = DispatchGroup()
        var datasUser = [TargetedUser]()
        
        for (index, _) in data.enumerated(){
            for idUser in data[index].idUser{
                if idUser != currentUserID{
                    arrayUser.append(idUser)
                }
            }
        }
        
        for (index, _) in arrayUser.enumerated(){
            myGroup.enter()
            Firestore.firestore().collection("users").document(arrayUser[index]).getDocument { document, error in
                if error != nil {
                    print(error as Any)
                }else if let document = document, document.exists{
                    let name = document.get("username") as? String ?? ""
                    let role = document.get("role") as? String ?? ""
                    let idPersonalChat = data[index].idPersonalChat
                    let idTargetedUser = arrayUser[index]
                    let dataUser = TargetedUser(username: name, role: role, idPersonalChat: idPersonalChat, idUser: idTargetedUser)
                    datasUser.append(dataUser)
                    myGroup.leave()
                }
            }
        }
        
        myGroup.notify(queue: .main){
            completion(datasUser)
        }
    }
}
