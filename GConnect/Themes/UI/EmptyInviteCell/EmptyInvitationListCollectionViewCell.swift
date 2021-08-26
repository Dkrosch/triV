//
//  EmptyInvitationListCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 26/08/21.
//

import UIKit

class EmptyInvitationListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    
    static func nib() -> UINib{
        return UINib(nibName: "EmptyInvitationListCollectionViewCell", bundle: nil)
    }
    
    static let identifier = "cellEmptyInvitationList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.borderWidth = 1
        viewBackground.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
    }
}
