//
//  ListChatLoungeCollectionViewCell.swift
//  GConnect
//
//  Created by Michael Tanakoman on 07/08/21.
//

import UIKit

class ListChatLoungeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var collectionViewRequirement: UICollectionView!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var viewProfilePicture: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelTotalMember: UILabel!
    
    var dataReq: [String] = []
    
    static func nib() -> UINib{
        return UINib(nibName: "ListChatLoungeCollectionViewCell", bundle: nil)
    }
    static let identifier = "cellChatLounge"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewRequirement.delegate = self
        collectionViewRequirement.dataSource = self
        
        collectionViewRequirement.register(RequirementExploreLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: RequirementExploreLoungeCollectionViewCell.identifier)
    }
}

extension ListChatLoungeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func setDataCollectionView(dataRequirement: DataRequirement){
        dataReq = []
        
        if dataRequirement.sentinel == true {dataReq.append("Sentinel")}
        if dataRequirement.initiator == true {dataReq.append("Initiator")}
        if dataRequirement.controller == true {dataReq.append("Controller")}
        if dataRequirement.duelist == true {dataReq.append("Duelist")}
        dataReq.append(dataRequirement.rank)
        dataReq.append(dataRequirement.gender)
        collectionViewRequirement.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataReq.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequirementExploreLoungeCollectionViewCell.identifier, for: indexPath) as! RequirementExploreLoungeCollectionViewCell
        
        cell.requirementExploreLoungeCellLabel.text = dataReq[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
