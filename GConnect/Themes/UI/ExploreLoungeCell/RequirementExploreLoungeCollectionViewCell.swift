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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setBackground(color: UIColor){
        //requirementExploreLoungeCellView.layer.backgroundColor = color.cgColor
        print("Hello")
    }
}
