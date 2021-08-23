//
//  ModelPeople.swift
//  GConnect
//
//  Created by Dion Lamilga on 23/08/21.
//

import Foundation

struct FilterPeople: Codable{
    var statusFilter: Bool
    var game: String
    var arrayRole: [Bool]
    var rank: String
    var gender: String
    var recon: String
    var support: String
    var offensive: String
    var defensive: String
    
    init(statusFilter: Bool, game: String, role: [Bool], rank: String, gender: String, recon: String, support: String, offensive: String, defensive: String){
        self.statusFilter = statusFilter
        self.game = game
        self.arrayRole = role
        self.rank = rank
        self.gender = gender
        self.recon = recon
        self.support = support
        self.offensive = offensive
        self.defensive = defensive
    }
}

struct Roles: Codable {
    var recon: String
    var support: String
    var offensive: String
    var defensive: String
}
