//
//  ProfileVisitorViewController.swift
//  GConnect
//
//  Created by Olga Husada on 30/07/21.
//

import UIKit

class ProfileVisitorViewController: UIViewController {
    
    @IBOutlet weak var heightAchievCollView: NSLayoutConstraint!
    @IBOutlet weak var heightProfileView: NSLayoutConstraint!
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var inviteButton: UIButton!
    
    @IBOutlet weak var aboutmeLabel: UILabel!
    @IBOutlet weak var aboutmeView: UIView!
    
    @IBOutlet weak var despLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var statView: UIView!
    
    @IBOutlet weak var achievmentLabel: UILabel!
    @IBOutlet weak var achievCollView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutmeView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        aboutmeView.layer.borderWidth = 1

        let nib = UINib(nibName: "\(AchievementProfileCollectionViewCell.self)", bundle: nil)
        achievCollView.register(nib, forCellWithReuseIdentifier: "achievementCell" )
        
        achievCollView.delegate = self
        achievCollView.dataSource = self

        achievCollView.isScrollEnabled = false
        
        achievCollView.layer.borderWidth = 1
        achievCollView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        
        heightProfileView.constant = 696 + (achievCollView.frame.size.height*10)
        
        heightAchievCollView.constant = achievCollView.frame.size.height*10
        
        print(achievCollView.frame.size.height)
        view.layoutIfNeeded()
        
        // Do any additional setup after loading the view.
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

extension ProfileVisitorViewController: UICollectionViewDelegate{
    
}

extension ProfileVisitorViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementProfileCollectionViewCell
        return cell
    }
    
    
}

extension ProfileVisitorViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 148)
    }
}

