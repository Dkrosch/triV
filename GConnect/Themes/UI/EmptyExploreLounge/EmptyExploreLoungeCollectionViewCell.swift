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
        
    }
}
