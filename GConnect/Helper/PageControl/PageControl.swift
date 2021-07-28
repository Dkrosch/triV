//
//  PageControl.swift
//  GConnect
//
//  Created by Dion Lamilga on 28/07/21.
//

import UIKit

class PageControl: UIViewController{
    
//    static func showLoginPage(currentStoryBoard: UIViewController){
//        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
//        let vc = loginStoryboard.instantiateViewController(identifier: "login") as! LoginViewController
//        currentStoryBoard.present(vc, animated: true)
//    }
    static func showLogin(currentStoryboard: UIViewController){
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = loginStoryboard.instantiateViewController(identifier: "login") as! LoginViewController
        currentStoryboard.present(vc, animated: true)
    }
    
}
