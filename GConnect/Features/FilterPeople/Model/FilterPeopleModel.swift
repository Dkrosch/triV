//
//  FilterPeopleModel.swift
//  GConnect
//
//  Created by Vincent on 23/08/21.
//

import Foundation

struct FilterPeople: Codable{
    var statusFilter: Bool
    var game: String
    var arrayRole: [Bool]
    var rank: String
    var gender: String
    
    init(statusFilter: Bool, game: String, role: [Bool], rank: String, gender: String){
        self.statusFilter = statusFilter
        self.game = game
        self.arrayRole = role
        self.rank = rank
        self.gender = gender
    }
}
