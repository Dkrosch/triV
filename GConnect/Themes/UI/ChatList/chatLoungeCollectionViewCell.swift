//
//  chatLoungeCollectionViewCell.swift
//  GConnect
//
//  Created by vincent meidianto on 06/08/21.
//

import UIKit

class chatLoungeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var profil: UIImageView!
    @IBOutlet weak var description: UILabel!
    @IBOutlet weak var rank: UIImageView!
    override func awakeFromNib() {
        cellBackground.layer.borderWidth = 1
        cellBackground.layer.borderColor = #colorLiteral(red: 0.9948269725, green: 0.5902305841, blue: 0.4685668945, alpha: 1)
        super.awakeFromNib()
        
    }

}
