//
//  ViewControllerChooseGameDetail.swift
//  GConnect
//
//  Created by Olga Husada on 28/07/21.
//

import UIKit

class ViewControllerChooseGameDetail: UIViewController{
    
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var rankTextFiled: UITextField!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
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
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.tag = 1
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        
        roleTextField.inputView = pickerView1
        rankTextFiled.inputView = pickerView2
        
        linkToGameAccBtn.layer.cornerRadius = 10.0
        linkToGameAccBtn.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 10.0
        continueButton.layer.masksToBounds = true
        
        statsView.layer.borderWidth = 1
        statsView.layer.borderColor = UIColor(named: "Vivid Tangerine")?.cgColor
        statsView.layer.cornerRadius = 10.0
        statsView.layer.masksToBounds = true
    }

}

extension ViewControllerChooseGameDetail: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
