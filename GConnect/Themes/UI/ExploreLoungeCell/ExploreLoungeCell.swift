//
//  ExploreLoungeCell.swift
//  GConnect
//
//  Created by Vincent on 28/07/21.
//

import UIKit

class ExploreLoungeCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var exploreLoungeCellView: UIView!
    @IBOutlet weak var loungeNameLabel: UILabel!
    @IBOutlet weak var totalMemberLabel: UILabel!
    @IBOutlet weak var descriptionLoungeLabel: UILabel!
    @IBOutlet weak var requirementExploreLoungeCollectionVIew: UICollectionView!
    @IBOutlet weak var gamesNameLabel: UILabel!
    
    private let cellId = "cell"
    var dataReq: [String] = []
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        requirementExploreLoungeCollectionVIew.delegate = self
        requirementExploreLoungeCollectionVIew.dataSource = self
        
        let nib = UINib(nibName: "\(RequirementExploreLoungeCollectionViewCell.self)", bundle: nil)
        requirementExploreLoungeCollectionVIew.register(nib, forCellWithReuseIdentifier: "cellContoh")
    }
    
    func configureCell(detailLounge: DetailLounge){
        var num = 10
        
        for member in detailLounge.idMemberLounge{
            if member == ""{
                num -= 1
            }
        }
        
        loungeNameLabel.text = detailLounge.title
        descriptionLoungeLabel.text = detailLounge.desc
        gamesNameLabel.text = "| \(detailLounge.game)"
        totalMemberLabel.text = "\(num)/10"
        
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
        
        exploreLoungeCellView.layer.borderWidth = 1
        exploreLoungeCellView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
    }
    
    func setDataCollectionView(dataRequirement: DataRequirement){
        dataReq = []
        if dataRequirement.sentinel == true {dataReq.append("Offensive")}
        if dataRequirement.initiator == true {dataReq.append("Support")}
        if dataRequirement.controller == true {dataReq.append("Defensive")}
        if dataRequirement.duelist == true {dataReq.append("Recon")}
        dataReq.append(dataRequirement.rank)
        dataReq.append(dataRequirement.gender)
        requirementExploreLoungeCollectionVIew.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataReq.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContoh", for: indexPath) as! RequirementExploreLoungeCollectionViewCell
        cell.requirementExploreLoungeCellLabel.text = dataReq[indexPath.row]
        print(dataReq[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 32)
    }
}

//https://stackoverflow.com/questions/17729582/uicollectionview-in-a-uicollectionviewcell
