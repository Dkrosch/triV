//
//  ProfileUserViewController.swift
//  GConnect
//
//  Created by Vincent on 29/07/21.
//

import UIKit

class ProfileUserViewController: UIViewController {

    @IBOutlet weak var viewContentProfileUser: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameLabelProfileUser: UILabel!
    @IBOutlet weak var aboutMeViewProfileUser: UIView!
    @IBOutlet weak var aboutMeDescriptionLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var buttonLogoutProfileUser: UIButton!
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    
//    var jumlahCell = 0
    @IBOutlet weak var achievementCollectionViewConstraintHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        aboutMeViewProfileUser.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        aboutMeViewProfileUser.layer.borderWidth = 1

        let nib = UINib(nibName: "\(AchievementProfileCollectionViewCell.self)", bundle: nil)
        achievementCollectionView.register(nib, forCellWithReuseIdentifier: "achievementCell" )
        
        achievementCollectionView.delegate = self
        achievementCollectionView.dataSource = self

        achievementCollectionView.isScrollEnabled = false
        
        achievementCollectionView.layer.borderWidth = 1
        achievementCollectionView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        
        viewContentHeightConstraint.constant = 696 + (achievementCollectionView.frame.size.height*10)
        
        achievementCollectionViewConstraintHeight.constant = achievementCollectionView.frame.size.height*10
        
        print(achievementCollectionView.frame.size.height)
        view.layoutIfNeeded()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileUserViewController: UICollectionViewDelegate{
    
}

extension ProfileUserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementProfileCollectionViewCell
        return cell
    }
    
    
}

extension ProfileUserViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 148)
    }
}
