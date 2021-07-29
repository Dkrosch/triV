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
    Game(title: "Valorant", image: #imageLiteral(resourceName: "Valorant")),
    Game(title: "PUBG-M", image: #imageLiteral(resourceName: "PUBG-M")),
    Game(title: "Dota 2", image: #imageLiteral(resourceName: "DOTA 2")),
    Game(title: "CS:GO", image: #imageLiteral(resourceName: "CS:GO")),
    Game(title: "Apex", image: #imageLiteral(resourceName: "Group 2")),
    Game(title: "Fortnite", image: #imageLiteral(resourceName: "Fortnite"))
]
