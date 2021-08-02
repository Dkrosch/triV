//
//  LoungeCollectionViewCell.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit

@IBDesignable
class DetailLoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var viewImageProfile: UIView!
    @IBOutlet weak var nama: UILabel!
    @IBOutlet weak var role: UILabel!
    
    static let identifier = "loungeMemberDetail"
    
    static func nib() -> UINib{
        return UINib(nibName: "DetailLoungeCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}