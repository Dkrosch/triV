//
//  InvitationListCell.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 20/08/21.
//

import UIKit

class InvitationListCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataReq.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContoh", for: indexPath) as! RequirementExploreLoungeCollectionViewCell
        cell.requirementExploreLoungeCellLabel.text = dataReq[indexPath.row]
        print(dataReq[indexPath.row])
        return cell
    }
    
    

    @IBOutlet weak var FromLabel: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var userRoleLabel: UILabel!
    @IBOutlet weak var loungeMemberqtyLbl: UILabel!
    @IBOutlet weak var loungeTitleLabel: UILabel!
    @IBOutlet weak var loungeDescLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    @IBOutlet weak var requirementLoungeCollectionView: UICollectionView!
    
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var AcceptBtn: UIButton!
    
    private let cellId = "cell"
    var dataReq: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        requirementLoungeCollectionView.delegate = self
        requirementLoungeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(RequirementExploreLoungeCollectionViewCell.self)", bundle: nil)
        requirementLoungeCollectionView.register(nib, forCellWithReuseIdentifier: "cellContoh")
       
    }
    
    func configureCell(detailLounge: DetailLounge){
        var num = 10
        
        for member in detailLounge.idMemberLounge{
            if member == ""{
                num -= 1
            }
        }
        
        loungeTitleLabel.text = detailLounge.title
        loungeDescLabel.text = detailLounge.desc
        loungeMemberqtyLbl.text = "\(num)/10"
        
        let sentinel = detailLounge.idRequirementsLounge[0]
        let initiator = detailLounge.idRequirementsLounge[1]
        let controller = detailLounge.idRequirementsLounge[2]
        let dueletist = detailLounge.idRequirementsLounge[3]
        let rank = detailLounge.rank
        let gender = detailLounge.gender
        let initDataReq = DataRequirement(controller: controller, duelist: dueletist, initiator: initiator, sentinel: sentinel, rank: rank, gender: gender)
        
        setDataCollectionView(dataRequirement: initDataReq)
        
        for member in detailLounge.idMemberLounge{
            if member == ""{
                num -= 1
            }
        }
        

    }
    
    func setDataCollectionView(dataRequirement: DataRequirement){
        dataReq = []
        if dataRequirement.sentinel == true {dataReq.append("Offensive")}
        if dataRequirement.initiator == true {dataReq.append("Support")}
        if dataRequirement.controller == true {dataReq.append("Defensive")}
        if dataRequirement.duelist == true {dataReq.append("Recon")}
        dataReq.append(dataRequirement.rank)
        dataReq.append(dataRequirement.gender)
        requirementLoungeCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 32)
    }
    
    
}
