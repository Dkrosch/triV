//
//  DetailLoungeViewController.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit

class DetailLoungeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Rank.layer.cornerRadius = 8
        Rank.layer.borderWidth = 1
        Rank.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        Game.layer.cornerRadius = 8
        Game.layer.borderWidth = 1
        Game.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        DescriptionTextbox.layer.cornerRadius = 8
        JoinLoungeButton.layer.cornerRadius = 8
        
    }


    
    let smokewhite = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)

    let darkblue = UIColor(red: 0.11, green: 0.17, blue: 0.33, alpha: 1.00)
    
    let rhino = UIColor(red: 0.18, green: 0.22, blue: 0.35, alpha: 1.00)
    
    let viking = UIColor(red: 1.00, green: 0.59, blue: 0.47, alpha: 1.00)
    
    //@IBOutlet
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var Game: UITextField!
    @IBOutlet weak var Rank: UITextField!
    @IBOutlet weak var roles: UICollectionView!
    @IBOutlet weak var DescriptionTextbox: UITextView!
    @IBOutlet weak var JoinLoungeButton: UIButton!
    
    
    }
