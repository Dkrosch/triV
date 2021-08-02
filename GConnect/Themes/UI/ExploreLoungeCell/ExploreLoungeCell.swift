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
    
    @IBAction func joinButton(_ sender: UIButton) {
    }
    
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
        totalMemberLabel.text = "\(num)"
        
        exploreLoungeCellView.layer.borderWidth = 1
        exploreLoungeCellView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContoh", for: indexPath) as! RequirementExploreLoungeCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

}

//https://stackoverflow.com/questions/17729582/uicollectionview-in-a-uicollectionviewcell
