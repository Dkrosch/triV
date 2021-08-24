//
//  EmptyPersonalChatListCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 24/08/21.
//

import UIKit

class EmptyPersonalChatListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelText: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "EmptyPersonalChatListCollectionViewCell", bundle: nil)
    }
    
    static let identifier = "cellEmptyListChatPersonal"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
