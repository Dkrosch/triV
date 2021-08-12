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
    
    static let identifier = "loungeMemberDetail"
    
    static func nib() -> UINib{
        return UINib(nibName: "LoungeCollectionViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        
    }

}
