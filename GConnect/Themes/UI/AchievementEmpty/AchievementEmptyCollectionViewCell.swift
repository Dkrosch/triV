//
//  AchievementEmptyCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 05/08/21.
//

import UIKit

class AchievementEmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var txtLabel: UILabel!
    
    static let identifier = "achievementEmpty"
    static func nib() -> UINib{
        return UINib(nibName: "AchievementEmptyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
