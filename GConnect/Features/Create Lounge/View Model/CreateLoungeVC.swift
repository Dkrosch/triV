//
//  CreateLoungeVC.swift
//  GConnect
//
//  Created by Daffa Satria on 27/07/21.
//

import UIKit

class CreateLoungeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        //PickerGender.dataSource = self
        //PickerGender.delegate = self
        SentinelButton.layer.cornerRadius = 8
        ControllerButton.layer.cornerRadius = 8
        InitiatorButton.layer.cornerRadius = 8
        DuellistButton.layer.cornerRadius = 8
        DescriptionTextbox.layer.cornerRadius = 8
        RankedTextfieldPicker.inputView = picker
        GenderTextfieldPicker.inputView = picker
        picker.backgroundColor = rhino
        CreateButton.layer.cornerRadius = 8
        CreateButton.backgroundColor = viking
    }

    let arrayDataRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Immortal", "Radiant"]
    let arrayGender = ["♂️Male", "♀ Female"]
    let picker = UIPickerView()
    var SelectedRole = [""]
    var SelectedRank = ""
    
    let smokewhite = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)

    let darkblue = UIColor(red: 0.11, green: 0.17, blue: 0.33, alpha: 1.00)
    
    let rhino = UIColor(red: 0.18, green: 0.22, blue: 0.35, alpha: 1.00)
    
    let viking = UIColor(red: 1.00, green: 0.59, blue: 0.47, alpha: 1.00)
    
    //@IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var ChooseRoleLabel: UILabel!
    
    @IBOutlet weak var SentinelButton: UIButton!
    @IBOutlet weak var InitiatorButton: UIButton!
    @IBOutlet weak var ControllerButton: UIButton!
    @IBOutlet weak var DuellistButton: UIButton!
    
    @IBOutlet weak var DescriptionTextbox: UITextView!
    
    @IBOutlet weak var CheckermarkSentinel: UIImageView!
    @IBOutlet weak var CheckmarkController: UIImageView!
    @IBOutlet weak var CheckmarkInitiator: UIImageView!
    @IBOutlet weak var CheckmarkDuellist: UIImageView!
    
    @IBOutlet weak var RankedTextfieldPicker: UITextField!
    @IBOutlet weak var GenderTextfieldPicker: UITextField!
    @IBOutlet weak var CreateButton: UIButton!
    
    var arrayrow = [""]
    var arraycount = 0

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if RankedTextfieldPicker.isEditing{
            arrayrow[row] = arrayDataRank[row]
        }else if GenderTextfieldPicker.isEditing{
            arrayrow[row] = arrayGender[row]
        }
        return arrayrow[row]
        //return arrayDataRank[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if RankedTextfieldPicker.isEditing{
            arraycount = arrayDataRank.count

        } else if GenderTextfieldPicker.isEditing{
            arraycount = arrayGender.count
        }
        return arraycount
        //return arrayDataRank.count
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if RankedTextfieldPicker.isEditing{
            RankedTextfieldPicker.text = arrayDataRank[row]
            RankedTextfieldPicker.resignFirstResponder()
        }
        else if GenderTextfieldPicker.isEditing {
            GenderTextfieldPicker.text = arrayGender[row]
            GenderTextfieldPicker.resignFirstResponder()
        }
        //RankedTextfieldPicker.text = arrayDataRank[row]
        
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var pickerLabel = view as? UILabel;

        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "SF Pro Display", size: 12)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        if RankedTextfieldPicker.isEditing{ pickerLabel?.text = arrayDataRank[row]
        }else if GenderTextfieldPicker.isEditing{
            pickerLabel?.text = arrayGender[row]
            
            //pickerLabel?.text = arrayDataRank[row]
        
        }
        pickerLabel?.textColor = smokewhite
        return pickerLabel!;
    }
    
    @IBAction func SentinelToggle(_ sender: Any) {
        CheckermarkSentinel.isHidden.toggle()
    }
    
    @IBAction func ControllerButtonToggle(_ sender: UIButton) {
        CheckmarkController.isHidden.toggle()
    }
    
    @IBAction func CheckmarkInitiatorToggle(_ sender: UIButton) {
        CheckmarkInitiator.isHidden.toggle()
    }
    
    @IBAction func CheckmarkDuellistToggle(_ sender: UIButton) {
        CheckmarkDuellist.isHidden.toggle()
    }
    
    @IBAction func CreateButtonifTapped(_ sender: UIButton) {
        
    }
    
    
    


}
