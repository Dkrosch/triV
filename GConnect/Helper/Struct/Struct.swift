//
//  Struct.swift
//  GConnect
//
//  Created by Dion Lamilga on 29/07/21.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

class Struct{
//       @DocumentID var id: String? = UUID().uuidString
    var title: String
    var desc: String
    var idMemberLounge: [String] // isi member
    var idRequirementsLounge: [String]// isi requirement
    var documentId: String
    var creatAt: String
    
    init(title: String, desc: String, idMemberLounge: [String], idRequirementsLounge: [String], documentId: String, creatAt: String) {
        self.title = title
        self.desc = desc
        self.idMemberLounge = idMemberLounge
        self.idRequirementsLounge = idRequirementsLounge
        self.documentId = documentId
        self.creatAt = creatAt
    }
}
