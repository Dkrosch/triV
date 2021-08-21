//
//  InvitationListCell.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 20/08/21.
//

import UIKit

class InvitationListCell: UICollectionViewCell {
    
    @IBOutlet weak var FromLabel: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var userRoleLabel: UILabel!
    @IBOutlet weak var loungeMemberqtyLbl: UILabel!
    @IBOutlet weak var loungeTitleLabel: UILabel!
    @IBOutlet weak var loungeDescLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    @IBOutlet weak var requirementLoungeCollectionView: UICollectionView!
    
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var AcceptBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
