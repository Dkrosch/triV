//
//  CreateLoungeVC.swift
//  GConnect
//
//  Created by Daffa Satria on 27/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateLoungeVC: UIViewController {

    @IBOutlet weak var ChooseRoleLabel: UILabel!
    
    @IBOutlet weak var btnSentinel: UIButton!
    @IBOutlet weak var btnInitiator: UIButton!
    @IBOutlet weak var btnController: UIButton!
    @IBOutlet weak var btnDuelist: UIButton!
    
    @IBOutlet weak var DescriptionTextbox: UITextView!
    
    @IBOutlet weak var txtFieldRanked: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var txtLoungeTitle: UITextField!
    
    @IBOutlet weak var CreateButton: UIButton!
    
    let arrayDataRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Immortal", "Radiant"]
    let arrayGender = ["♂️Male", "♀ Female"]
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    var selectedRole: [Bool] = [false, false, false, false]
    var statusSentinel = false
    var statusInitiator = false
    var statusController = false
    var statusDuelist = false
    
    var createLoungeVM = CreateLoungeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.hideKeyboardWhenTappedAround()
        
        pickerView1.dataSource = self
        pickerView1.delegate = self
        pickerView1.tag = 1
        
        pickerView2.dataSource = self
        pickerView2.delegate = self
        pickerView2.tag = 2

        btnSentinel.layer.cornerRadius = 8
        btnController.layer.cornerRadius = 8
        btnInitiator.layer.cornerRadius = 8
        btnDuelist.layer.cornerRadius = 8
        DescriptionTextbox.layer.cornerRadius = 8
        CreateButton.layer.cornerRadius = 8
        
        txtFieldRanked.inputView = pickerView1
        txtFieldRanked.setLeftPaddingPoints(10)
        
        txtFieldGender.inputView = pickerView2
        txtFieldGender.setLeftPaddingPoints(10)
        
        CreateButton.backgroundColor = UIColor(named: "Vivid Tangerine")
    }
    
    @IBAction func btnSentinelTapped(_ sender: Any) {
        changeStatusRole(status: statusSentinel, sender: sender as! UIButton){ status in
            self.statusSentinel = status
            self.selectedRole[0] = status
        }
    }
    
    @IBAction func btnInitiatorTapped(_ sender: Any) {
        changeStatusRole(status: statusInitiator, sender: sender as! UIButton){ status in
            self.statusInitiator = status
            self.selectedRole[1] = status
        }
    }
    
    @IBAction func btnControllerTapped(_ sender: Any) {
        changeStatusRole(status: statusController, sender: sender as! UIButton){ status in
            self.statusController = status
            self.selectedRole[2] = status
        }
    }
    
    @IBAction func btnDuelistTapped(_ sender: Any) {
        changeStatusRole(status: statusDuelist, sender: sender as! UIButton){ status in
            self.statusDuelist = status
            self.selectedRole[3] = status
        }
    }
    
    func changeStatusRole(status: Bool, sender: UIButton, passStatus: @escaping (Bool) -> Void){
        if status == false{
            sender.setImage(UIImage(named: "Checkmark_icon"), for: .normal)
            sender.semanticContentAttribute = .forceRightToLeft
            passStatus(true)
        }else{
            sender.setImage(nil, for: .normal)
            passStatus(false)
        }
    }
    
    @IBAction func btnCreateLoungeTapped(_ sender: Any) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print(selectedRole)
        createLoungeVM.createLoungeData(title: txtLoungeTitle.text!, role: selectedRole, rank: txtFieldRanked.text!, gender: txtFieldGender.text!, desc: DescriptionTextbox.text, uid: userID)
    }
}

extension CreateLoungeVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return arrayDataRank[row]
        case 2:
            return arrayGender[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return arrayDataRank.count
        case 2:
            return arrayGender.count
        default:
            return 0
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            txtFieldRanked.text = self.arrayDataRank[row]
            txtFieldRanked.resignFirstResponder()
        case 2:
            txtFieldGender.text = self.arrayGender[row]
            txtFieldGender.resignFirstResponder()
        default:
            return
        }
    }
}
