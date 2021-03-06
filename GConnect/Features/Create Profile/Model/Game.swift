//
//  Game.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 29/07/21.
//

import UIKit

struct Game{
    let title: String
    let image: UIImage
}

let games: [Game] = [
    Game(title: "APEX LEGEND", image: #imageLiteral(resourceName: "Apex3x")),
    Game(title: "PUBG-M", image: #imageLiteral(resourceName: "PUBG-M")),
    Game(title: "DOTA 2", image: #imageLiteral(resourceName: "DOTA 2")),
    Game(title: "CS:GO", image: #imageLiteral(resourceName: "CS:GO")),
    Game(title: "VALORANT", image: #imageLiteral(resourceName: "Valorant3x")),
    Game(title: "FORTNITE", image: #imageLiteral(resourceName: "Fortnite"))
]
