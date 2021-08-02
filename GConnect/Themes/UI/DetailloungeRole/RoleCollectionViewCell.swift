//
//  RoleCollectionViewCell.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit

class RoleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var role: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        role.layer.borderWidth = 2
        role.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
    }

}
