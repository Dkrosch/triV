//
//  LoungeCollectionViewCell.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit
import Firebase

protocol dataLounge{
    func tapped(indexMember: String, id: String, index: Int)
}

@IBDesignable
class DetailLoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var viewImageProfile: UIView!
    @IBOutlet weak var nama: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var kickButton: UIButton!
    
    static let identifier = "loungeMemberDetail"
    
    var idLounge: String?
    var idMember: String?
    var indx: IndexPath?
    
    var delegate: dataLounge?
    
    static func nib() -> UINib{
        return UINib(nibName: "DetailLoungeCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kickButton.isHidden = true
    }

    
    @IBAction func kickTapped(_ sender: Any) {

        delegate?.tapped(indexMember: idMember!, id: idLounge!, index: indx!.row)

            let db = Firestore.firestore()
            db.collection("LoungeDetail").document(idLounge!).updateData(["idMemberLounge.Member\(idMember!)": ""]){ (error) in
                if error != nil {
                    print (error)
                }else{
                    print("sukses")
                }
        }
    }
}
