//
//  TabBarViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 27/08/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (defaults.object(forKey: "isUserSignedIn") != nil) == false{
            let index = 3
            viewControllers?.remove(at: index)
        } else if (defaults.object(forKey: "isUserSignedIn") != nil) == true {
            let index = 4
            viewControllers?.remove(at: index)
        }
        
        self.navigationController?.isNavigationBarHidden = true
    }
}
