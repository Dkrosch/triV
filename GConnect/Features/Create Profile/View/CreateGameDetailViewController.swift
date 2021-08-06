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
    @IBOutlet weak var rankTextFiled: UITextField!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var gameCoverImage: UIImageView!
    
    
    //statistics
    @IBOutlet weak var statsTitleLabel: UILabel!
    @IBOutlet weak var statsSubtitleLabel: UILabel!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var statsHeaderView: UIView!
    @IBOutlet weak var gameIconImage: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var linkToGameAccBtn: UIButton!
        
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var name = ""
    
    let listRole = ["Sentinel", "Controller", "Initiator", "Duelist"]
    let listRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Immortal", "Radiant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.tag = 1
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        
        roleTextField.inputView = pickerView1
        rankTextFiled.inputView = pickerView2
        
        //rounded button
        linkToGameAccBtn.layer.cornerRadius = 10.0
        linkToGameAccBtn.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 10.0
        continueButton.layer.masksToBounds = true
        
        //statsview
        statsView.layer.borderWidth = 1
        statsView.layer.borderColor = UIColor(named: "Vivid Tangerine")?.cgColor
        statsView.layer.cornerRadius = 10.0
        statsView.layer.masksToBounds = true
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let role = roleTextField.text
        let rank = rankTextFiled.text
        let game = "valorant"

        if roleTextField.text == "Choose your role" && rankTextFiled.text == "Choose your rank"{
            print("ga bisa bang")
        }else{
            db.collection("users").document(userID).updateData(["game": game, "role" : role, "rank" : rank]) {(error) in
                if error != nil{
                    print("Gagal")
                } else {
                    print("Sukses")
                }
            }
            
            var dataFilter = FilterLounge(game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
            let encoder = JSONEncoder()
            if let filter = try? encoder.encode(dataFilter){
                UserDefaults.standard.set(filter, forKey: "filterLounge")
            }
            
            performSegue(withIdentifier: "ExploreLounge", sender: self)
        }
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
        case 2:
            rankTextFiled.text = self.listRank[row]
            rankTextFiled.resignFirstResponder()
        default:
            return
        }
    }
}
