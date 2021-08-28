//
//  ExplorePeopleViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import UIKit

protocol ExplorePeopleUIViewDelegate{
    func goToHome(idUser: String)
}

extension ExplorePeopleViewController: ExplorePeopleUIViewDelegate{
    func goToHome(idUser: String) {
        if (defaults.object(forKey: "isUserSignedIn") != nil) == false{
            let alert = UIAlertController(title: "Warning", message: "U must Login First", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancle", style: .destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if (defaults.object(forKey: "isUserSignedIn") != nil) == true {
            let showProfile = UIStoryboard(name: "ProfileUser", bundle: nil)
            let vc = showProfile.instantiateViewController(identifier: "ProfileUser") as! ProfileUserViewController
            vc.idMemberVisitor = idUser
            vc.statusVisitor = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class ExplorePeopleViewController: UIViewController {

    @IBOutlet var explorePeopleUI: ExplorePeopleUIView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        explorePeopleUI.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        let filterPeople = UIStoryboard(name: "FilterPeople", bundle: nil)
        let vc = filterPeople.instantiateViewController(identifier: "filterPeople") as! FilterExplorePeopleViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        explorePeopleUI.configureView()
    }
}
