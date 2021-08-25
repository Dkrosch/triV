//
//  PersonalChatCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 23/08/21.
//

import UIKit

class PersonalChatCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var profilePic: ProfilePicView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelLastChat: UILabel!
    @IBOutlet weak var background: UIView!
    
    static func nib() -> UINib{
        return UINib(nibName: "PersonalChatCollectionViewCell", bundle: nil)
    }
    
    static let identifier = "cellPersonalChat"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
