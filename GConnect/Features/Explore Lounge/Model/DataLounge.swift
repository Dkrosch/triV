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
