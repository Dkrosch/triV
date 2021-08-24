//
//  ViewModelExplorePeople.swift
//  GConnect
//
//  Created by Dion Lamilga on 19/08/21.
//

import Foundation

extension FilterExplorePeopleViewController{
    func viewConfigure(){
        btnSentinel.layer.cornerRadius = 10
        btnInitiator.layer.cornerRadius = 10
        btnController.layer.cornerRadius = 10
        btnDuelist.layer.cornerRadius = 10
        txtFieldRank.layer.cornerRadius = 10
        txtFieldGender.layer.cornerRadius = 10
        btnSetFilter.layer.cornerRadius = 10
        btnRemoveFilter.layer.cornerRadius = 10
        btnRemoveFilter.layer.borderWidth = 1
        btnRemoveFilter.layer.borderColor = #colorLiteral(red: 1, green: 0.537874639, blue: 0.4000282884, alpha: 1)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        pickerView1.dataSource = self
        pickerView1.delegate = self
        pickerView1.tag = 1
        pickerView2.dataSource = self
        pickerView2.delegate = self
        pickerView2.tag = 2
        txtFieldRank.inputView = pickerView1
        txtFieldRank.setLeftPaddingPoints(10)
        txtFieldGender.inputView = pickerView2
        txtFieldGender.setLeftPaddingPoints(10)
        errorMessage.isHidden = true
    }
    
    func storeFilter(){
        if let savedFilter = UserDefaults.standard.object(forKey: "filterPeople") as? Data{
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(FilterPeople.self, from: savedFilter){
                filter = loadedFilter
            }
        }
        
        if filter?.statusFilter == true{
            btnRemoveFilter.isHidden = false
        }else{
            btnRemoveFilter.isHidden = true
        }
        
        arrayStatusRole = filter!.arrayRole
        roleRecon = filter!.recon
        roleSupport = filter!.support
        roleDefensive = filter!.defensive
        roleOffensive = filter!.offensive
        
        let controller = filter!.arrayRole[0]
        let duelist = filter!.arrayRole[1]
        let initiator = filter!.arrayRole[2]
        let sentinel = filter!.arrayRole[3]
        
        if controller == true {
            print("controller")
            roleDefensive = "Defensive"
            self.setButtonRole(sender: btnController)
        }
        if duelist == true{
            print("duelist")
            roleRecon = "Recon"
            self.setButtonRole(sender: btnDuelist)
            //roles?[1] = "Recon"
        }
        if initiator == true{
            print("initiator")
            roleSupport = "Support"
           // roles?[2] = "Support"
            self.setButtonRole(sender: btnInitiator)
        }
        if sentinel == true{
            print("sentinel")
            roleOffensive = "Offensive"
            self.setButtonRole(sender: btnSentinel)
          //  roles?[3] = "Offensive"
        }
        txtFieldRank.text = filter?.rank
        txtFieldGender.text = filter?.gender
        
        print("Ini Gender:: \(filter?.gender)")
    }
    
    
    func setFilter(){
        if arrayStatusRole == [false, false, false, false]{
            showErrorMessage(msg: "Choose minimal 1 role")
        }else if txtFieldRank.text == "" || txtFieldGender.text == ""{
            showErrorMessage(msg: "Fill all data")
        }else{
            print(txtFieldGender.text ?? "")
            let dataFilter = FilterPeople(statusFilter: true, game: "Apex Legends", role: arrayStatusRole, rank: txtFieldRank.text!, gender: txtFieldGender.text!, recon: roleRecon, support: roleSupport, offensive: roleOffensive, defensive: roleDefensive)
            let encoder = JSONEncoder()
            if let filter = try? encoder.encode(dataFilter){
                UserDefaults.standard.set(filter, forKey: "filterPeople")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func removeFilter(){
        let dataFilter = FilterPeople(statusFilter: false, game: "Apex Legends", role: [true, true, true, true], rank: "Rank", gender: "All", recon: "Recon", support: "Support", offensive: "Offensive", defensive: "Defensive")
        let encoder = JSONEncoder()
        if let filter = try? encoder.encode(dataFilter){
            UserDefaults.standard.set(filter, forKey: "filterPeople")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func showErrorMessage(msg: String){
        errorMessage.isHidden = false
        errorMessage.text = msg
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector (self.hideWrongLabel), userInfo: nil, repeats: false)
    }
}
