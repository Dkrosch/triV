//
//  TestTextViewViewController.swift
//  GConnect
//
//  Created by Vincent on 01/08/21.
//

import UIKit

class TestTextViewViewController: UIViewController {

    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var stackViewBio: UIStackView!
    @IBOutlet weak var textViewBio: UITextView!
    @IBOutlet weak var textViewUsername: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stackViewUsername.isHidden = true
//        textViewBio.layer.zPosition = 1001
//        view.bringSubviewToFront(textViewBio)
        
        textViewBio.isScrollEnabled = false
        textViewUsername.isScrollEnabled = false
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
