//
//  DataLounge.swift
//  GConnect
//
//  Created by Dion Lamilga on 29/07/21.
//

import UIKit
import Firebase


class DataLounge: UIViewController{
    
    static func countData(){
        let db = Firestore.firestore()
        var count = 0
        db.collection("LoungeDetail").getDocuments(){
            (querySnapshot, err) in
            if let err = err{
                print("error")
            } else {
                for document in querySnapshot!.documents{
                    count += 1
                    print("\(document.documentID) => \(document.data())")
                }
                print(count)
            }
        }
    }
    
    
//    func showDatas() -> [DetailLounge]{
//        var datas = [DetailLounge]()
//        var collectionRef: CollectionReference!
//        collectionRef = Firestore.firestore().collection("LoungeDetail")
//
//        collectionRef.getDocuments { snapshot, error in
//            if let err = error{
//                print("error")
//            } else {
//                for document in (snapshot?.documents)!{
//                    let data = document.data()
//                    let creatAt = data["CreatAt"] as? String ?? ""
//                    let desc = data["Desc"] as? String ?? ""
//                    let judul = data["Title"] as? String ?? ""
//                    let idMemberLounge = data["idMemberLounge"] as? [String: Any]
//                    let member1 = idMemberLounge!["Member1"] as? String
//                    let member2 = idMemberLounge!["Member2"] as? String
//                    let member3 = idMemberLounge!["Member3"] as? String
//                    let member4 = idMemberLounge!["Member4"] as? String
//                    let member5 = idMemberLounge!["Member5"] as? String
//                    let member6 = idMemberLounge!["Member6"] as? String
//                    let member7 = idMemberLounge!["Member7"] as? String
//                    let member8 = idMemberLounge!["Member8"] as? String
//                    let member9 = idMemberLounge!["Member9"] as? String
//                    let member10 = idMemberLounge!["Member10"] as? String
//                    let idRequirementsLounge = data["idRequirementsLounge"] as? [String: Any]
//                    let gender = idRequirementsLounge!["Gender"] as? String
//                    let rank = idRequirementsLounge!["Rank"] as? String
//                    let role1 = idRequirementsLounge!["Role1"] as? String
//                    let role2 = idRequirementsLounge!["Role2"] as? String
//                    let role3 = idRequirementsLounge!["Role3"] as? String
//                    let role4 = idRequirementsLounge!["Role4"] as? String
//                    let documentId = document.documentID
//
//
//                    let Newdatas = DetailLounge(title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [gender!, rank!, role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt)
//
//                    datas.append(Newdatas)
//                }
//            }
//        }
//        return datas
//    }
}
