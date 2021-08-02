//
//  ProfilePickRankCollectionViewCell.swift
//  GConnect
//
//  Created by Daffa Satria on 30/07/21.
//

import UIKit

@IBDesignable
class ProfilePickRankCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ProfilePic.layer.cornerRadius = ProfilePic.frame.height/2
        ProfilePic.layer.masksToBounds = false
        ProfilePic.clipsToBounds = true
        // Initialization code
    }

    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var RankThumbnail: UIImageView!
    
    
    
    
}
