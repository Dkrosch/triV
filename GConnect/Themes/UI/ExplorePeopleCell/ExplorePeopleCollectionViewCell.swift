//
//  ExplorePeopleCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 19/08/21.
//

import UIKit

class ExplorePeopleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profilePicture: ProfilePicView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelRoleUser: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    
    static let identifier = "exploreLoungeCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ExplorePeopleCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
