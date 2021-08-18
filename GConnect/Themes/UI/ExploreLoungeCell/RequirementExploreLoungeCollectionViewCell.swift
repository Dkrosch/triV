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
        
    }
    
    func configureCell(){
        layer.cornerRadius = 10
        layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        layer.borderWidth = 2
        requirementExploreLoungeCellView.layer.backgroundColor = #colorLiteral(red: 0.1682771742, green: 0.2152610421, blue: 0.3345189095, alpha: 1)
    }

}
