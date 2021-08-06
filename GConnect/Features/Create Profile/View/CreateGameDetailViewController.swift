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

    let listRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "APEX Predator"]
    let listRole = ["Offensive","Recon","Defensive","Support"]

    
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
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        uName = gamerUnameTextField.text!
        
        storeData(uname: uName)
        
        loadingView.isHidden = false
        loading()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false){ (timer) in
            self.dismiss(animated: true)
            self.loadingView.isHidden = true
        }
        
    }
    
    func storeData(uname: String){
        
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ApiService.getDatas(url: "https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=\(uname)&auth=i6Xau6J5JvKzMy9J3LXI") { (response, error) in
            if response != nil {
                if let responseFromAPI = response {
                    if responseFromAPI.global?.name == nil {
                        self.alert()
                    } else {
                        let db = Firestore.firestore()
                        let role = self.roleTextField.text
                        let rank = responseFromAPI.global!.rank!.rankName!
                        let gamerUname = self.gamerUnameTextField.text
                        let game = "Apex"

                        if self.roleTextField.text == "Choose your role"{
                            print("ga bisa bang")
                        }else{
                            db.collection("users").document(userID).updateData(["game": game, "role" : role, "rank" : rank, "gamerUname": gamerUname]) {(error) in
                                if error != nil{
                                    print("Gagal")
                                } else {
                                    print("Sukses")
                                }
                            }
                            var dataFilter = FilterLounge(game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
                            let encoder = JSONEncoder()
                            if let filter = try? encoder.encode(dataFilter){
                            }
                        self.performSegue(withIdentifier: "ExploreLounge", sender: self)
                        }

                    }
                }
            }
        } failCompletion: { error in
            print(error)
        }
        
    }
    
    func alert(){
        let alert = UIAlertController(title: "Warning", message: "Username is incorrect", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func loading(){
        let loadingModal = UIStoryboard(name: "Loading", bundle: nil)
        let vc = loadingModal.instantiateViewController(identifier: "loadingScreen") as! LoadingViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
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
