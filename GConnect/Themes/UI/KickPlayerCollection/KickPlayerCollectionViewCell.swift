//
//  KickPlayerCollectionViewCell.swift
//  GConnect
//
//  Created by Dion Lamilga on 31/07/21.
//

import UIKit

class KickPlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var imageRank: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelRole: UILabel!
    
    static let identifier = "loungeDetailKickMember"
    
    
    static func nib() -> UINib{
        return UINib(nibName: "KickPlayerCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(dataPlayer: ProfileData){
        imageProfile.image = UIImage(named: dataPlayer.imageProfile)
        labelName.text = dataPlayer.username
        labelRole.text = dataPlayer.role
        imageRank.image = UIImage(named: dataPlayer.imageRank)
    }
    
}
