//
//  Struct.swift
//  GConnect
//
//  Created by Dion Lamilga on 29/07/21.
//

import Foundation
import UIKit

class Struct{
    //       @DocumentID var id: String? = UUID().uuidString
    var game: String
    var title: String
    var desc: String
    var idMemberLounge: [String] // isi member
    var idRequirementsLounge: [Bool]// isi requirement
    var documentId: String
    var creatAt: String
    var gender: String
    var rank: String
    
    init(game: String, title: String, desc: String, idMemberLounge: [String], idRequirementsLounge: [Bool], documentId: String, creatAt: String, gender: String, rank: String) {
        self.game = game
        self.title = title
        self.desc = desc
        self.idMemberLounge = idMemberLounge
        self.idRequirementsLounge = idRequirementsLounge
        self.documentId = documentId
        self.creatAt = creatAt
        self.gender = gender
        self.rank = rank
    }
}

