//
//  EmptyExploreLoungeCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 08/08/21.
//

import UIKit

class EmptyExploreLoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    
    static func nib() -> UINib{
        return UINib(nibName: "EmptyExploreLoungeCollectionViewCell", bundle: nil)
    }
    
    static let identifier = "cellEmpty"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        viewBackground.layer.borderWidth = 1
        
    }
}
