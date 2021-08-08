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
    
    func changeSelectedGames(){
        
    }
}
