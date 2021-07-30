//
//  LoungeCollectionViewCell.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit

class LoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var profil: UIImageView!
    @IBOutlet weak var rank: UIImageView!
    @IBOutlet weak var nama: UILabel!
    @IBOutlet weak var role: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.borderWidth = 2
        background.layer.borderColor = #colorLiteral(red: 1, green: 0.5644452572, blue: 0.4353580177, alpha: 1)
       
    }

}
