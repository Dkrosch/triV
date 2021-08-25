//
//  EmptyListLoungeCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 08/08/21.
//

import UIKit

class EmptyListLoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    
    static func nib() -> UINib{
        return UINib(nibName: "EmptyListLoungeCollectionViewCell", bundle: nil)
    }
    
    static let identifier = "cellEmptyListChat"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
