//
//  CreateGameDetailViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 29/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateGameDetailViewController: UIViewController {

    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var gameCoverImage: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    //statistics
    @IBOutlet weak var statsTitleLabel: UILabel!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var statsHeaderView: UIView!
    @IBOutlet weak var gameIconImage: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gamerUnameTextField: UITextField!
    

    
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var name = ""
    var uName = ""
    var defaults = UserDefaults.standard

    let listRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "APEX Predator"]
    let listRole = ["Offensive","Recon","Defensive","Support"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        errorMessage.isHidden = true
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.tag = 1
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        
        roleTextField.inputView = pickerView1
        
        //rounded button
        
        continueButton.layer.cornerRadius = 10.0
        continueButton.layer.masksToBounds = true
        
        //statsview
        statsView.layer.borderWidth = 1
        statsView.layer.borderColor = UIColor(named: "Vivid Tangerine")?.cgColor
        statsView.layer.cornerRadius = 10.0
        statsView.layer.masksToBounds = true
        
        loadingView.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        uName = gamerUnameTextField.text!
        storeData(uname: uName)
        self.defaults.set(true, forKey: "isUserSignedIn")
        self.defaults.synchronize()
    }
    
    func showErrorMessage(message: String){
        errorMessage.isHidden = false
        errorMessage.text = message
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector (self.hideWrongLabel), userInfo: nil, repeats: false)
    }
    
    @objc func hideWrongLabel(){
        self.errorMessage.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Create Profile"
    }

}

extension CreateGameDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return listRole.count
        case 2:
            return listRank.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return listRole[row]
        case 2:
            return listRank[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            roleTextField.text = self.listRole[row]
            roleTextField.resignFirstResponder()
        default:
            return
        }
    }
}
