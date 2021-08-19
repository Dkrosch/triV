//
//  DataModelPeople.swift
//  GConnect
//
//  Created by Vincent on 19/08/21.
//

import UIKit
import Firebase

class DataModelPeople: UIViewController{
    
    static func countData(){
        let db = Firestore.firestore()
        var count = 0
        db.collection("users").getDocuments(){
            (querySnapshot, err) in
            if err != nil{
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

