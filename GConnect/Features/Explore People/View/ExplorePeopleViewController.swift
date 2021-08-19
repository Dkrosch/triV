//
//  ExplorePeopleViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import UIKit

class ExplorePeopleViewController: UIViewController {

    @IBOutlet var explorePeopleUI: ExplorePeopleUIView!
    
    var dataPeople = DataPeople()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        explorePeopleUI.configureView()
//        explorePeopleUI.userCollectionView.
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
}
