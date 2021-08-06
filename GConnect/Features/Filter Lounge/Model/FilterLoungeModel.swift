//
//  FilterLoungeModel.swift
//  GConnect
//
//  Created by Michael Tanakoman on 05/08/21.
//

import UIKit

struct FilterLounge: Codable{
    var game: String
    var arrayRole: [Bool]
    var rank: String
    var gender: String
    
    init(game: String, role: [Bool], rank: String, gender: String){
        self.game = game
        self.arrayRole = role
        self.rank = rank
        self.gender = gender
    }
}
