//
//  Struct.swift
//  GConnect
//
//  Created by Dion Lamilga on 29/07/21.
//

import Foundation
import UIKit

<<<<<<< Updated upstream
class DetailLounge{
=======
class Struct{
//       @DocumentID var id: String? = UUID().uuidString
    var game: String
>>>>>>> Stashed changes
    var title: String
    var desc: String
    var idMemberLounge: [String]
    var idRequirementsLounge: [String]
    var documentId: String
    var creatAt: String
    
<<<<<<< Updated upstream
    init(title: String, desc: String, idMemberLounge: [String], idRequirementsLounge: [String], documentId: String, creatAt: String) {
=======
    init(game: String, title: String, desc: String, idMemberLounge: [String], idRequirementsLounge: [Bool], documentId: String, creatAt: String, gender: String, rank: String) {
        self.game = game
>>>>>>> Stashed changes
        self.title = title
        self.desc = desc
        self.idMemberLounge = idMemberLounge
        self.idRequirementsLounge = idRequirementsLounge
        self.documentId = documentId
        self.creatAt = creatAt
    }
}

