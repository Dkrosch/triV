//
//  ConfigureView.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import Foundation
import UIKit

extension ProfileUserViewController{
    
    func viewConfigure(){
        statsView.layer.borderWidth = 1
        statsView.layer.borderColor = UIColor(named: "Vivid Tangerine")?.cgColor
        statsView.layer.cornerRadius = 10.0
        statsView.layer.masksToBounds = true
        
        statsView1.layer.borderWidth = 2
        statsView1.layer.borderColor = UIColor(named: "Red")?.cgColor
        statsView2.layer.borderWidth = 2
        statsView2.layer.borderColor = UIColor(named: "Red")?.cgColor
        statsView3.layer.borderWidth = 2
        statsView3.layer.borderColor = UIColor(named: "Red")?.cgColor

        achievementCollectionView.isScrollEnabled = true
        achievementCollectionView.isUserInteractionEnabled = true
        
        achievementCollectionView.layer.borderWidth = 1
        achievementCollectionView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        
        buttonLogoutProfileUser.layer.cornerRadius = 8
        stackAboutMeTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        aboutMeTextField.isEditable = false
        self.hideKeyboardWhenTappedAround()
        stackUsernameView.isHidden = true
        changeProfilePicButton.isHidden = true
        aboutMeTextField.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 12)
    }
}
