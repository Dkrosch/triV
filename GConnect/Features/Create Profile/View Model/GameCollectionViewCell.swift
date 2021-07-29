//
//  GameCollectionViewCell.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 29/07/21.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with game: Game){
        gameImageview.image = game.image
        titleLabel.text = game.title
    }
}
