//
//  GamesCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 31/07/21.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewDisabled: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCellAvailabel(games: Games){
        lblGameName.text = games.gameName
        imgGame.image = games.gameImage.getImage()
        viewBackground.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func configureCell(){
        isUserInteractionEnabled = false
        viewDisabled.layer.cornerRadius = 10
        viewDisabled.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6916429128)
    }
}
