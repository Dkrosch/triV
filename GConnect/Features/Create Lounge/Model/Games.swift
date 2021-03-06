//
//  Games.swift
//  GConnect
//
//  Created by Michael Tanakoman on 31/07/21.
//

import UIKit

enum GamesImage{
    case apexLegends
    case valorant
    case pubgm
    
    func getImage() -> UIImage{
        switch self {
        case .apexLegends: return UIImage(named: "Apex Legends")!
        case .valorant: return #imageLiteral(resourceName: "VALORANT_Logo_square")
        case .pubgm: return UIImage(named: "pubg-mobile-logo")!
        }
    }
}

struct Games {
    var gameImage: GamesImage
    var gameName: String = ""
    
    static func getData() -> [Games]{
        var data: [Games] = []
        
        data.append(Games(gameImage: .apexLegends, gameName: "Apex Legends"))
        data.append(Games(gameImage: .pubgm, gameName: "PUBG-M"))
        data.append(Games(gameImage: .valorant, gameName: "Valorant"))
        
        return data
    }
}
