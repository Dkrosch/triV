//
//  LoungeMember.swift
//  GConnect
//
//  Created by Michael Tanakoman on 03/08/21.
//

import UIKit

class LoungeMember{
    var idMember: String
    var name: String
    var rank: String
    var imageProfile: String
    var role: String
    
    init(idMember: String, name: String, rank: String, imageProfile: String, role: String){
        self.idMember = idMember
        self.name = name
        self.rank = rank
        self.imageProfile = imageProfile
        self.role = role
    }
}
