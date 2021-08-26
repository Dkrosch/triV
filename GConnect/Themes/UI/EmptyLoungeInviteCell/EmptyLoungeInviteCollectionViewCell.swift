//
//  EmptyLoungeInviteCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 26/08/21.
//

import UIKit

class EmptyLoungeInviteCollectionViewCell: UICollectionViewCell {

    static func nib() -> UINib{
        return UINib(nibName: "EmptyLoungeInviteCollectionViewCell", bundle: nil)
    }
    
    static let identifier = "cellEmptyInvite"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
