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
}

struct DataRequirement {
    var controller: Bool
    var duelist: Bool
    var initiator: Bool
    var sentinel: Bool
    var rank: String
    var gender: String
    
    init(controller: Bool, duelist: Bool, initiator: Bool, sentinel: Bool, rank: String, gender: String) {
        self.controller = controller
        self.duelist = duelist
        self.initiator = initiator
        self.sentinel = sentinel
        self.rank = rank
        self.gender = gender
    }
}
