//
//  AchievementProfileCollectionViewCell.swift
//  GConnect
//
//  Created by Vincent on 30/07/21.
//

import UIKit

class AchievementProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var achievementProfileView: UIView!
    @IBOutlet weak var titleLabelAchievement: UILabel!
    @IBOutlet weak var descriptionLabelAchievement: UILabel!
    @IBOutlet weak var imageViewAchievement: UIImageView!
    @IBOutlet weak var buttonEdit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func dataAchivement(achivement: Achivement){
        titleLabelAchievement.text = achivement.title
        descriptionLabelAchievement.text = achivement.desc
        if let url = URL(string: achivement.image){
            do{
                let data = try Data(contentsOf: url)
                //imageViewAchievement.image = UIImage(data: data)
            } catch{
                print("error")
            }
        }
    }
}
