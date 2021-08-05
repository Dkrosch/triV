//
//  LoadingViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 05/08/21.
//

import UIKit

class LoadingViewController: UIViewController {

    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingSpinner.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false){ (timer) in
            self.dismiss(animated: true){
                self.loadingSpinner.stopAnimating()
            }
        }
    }
}
