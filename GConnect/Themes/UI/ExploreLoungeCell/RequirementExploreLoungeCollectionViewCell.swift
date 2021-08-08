//
//  RequirementExploreLoungeCollectionViewCell.swift
//  GConnect
//
//  Created by Vincent on 28/07/21.
//

import UIKit

class RequirementExploreLoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var requirementExploreLoungeCellLabel: UILabel!
    @IBOutlet weak var requirementExploreLoungeCellView: UIView!
    
    static func nib() -> UINib{
        return UINib(nibName: "RequirementExploreLoungeCollectionViewCell", bundle: nil)
    }
    static let identifier = "cellContoh"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
