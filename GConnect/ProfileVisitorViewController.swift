//
//  ProfileVisitorViewController.swift
//  GConnect
//
//  Created by Olga Husada on 30/07/21.
//

import UIKit

class ProfileVisitorViewController: UIViewController {
    
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
