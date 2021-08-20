//
//  ExplorePeopleViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import UIKit

class ExplorePeopleViewController: UIViewController {

    @IBOutlet var explorePeopleUI: ExplorePeopleUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        explorePeopleUI.configureView()
    }
}
