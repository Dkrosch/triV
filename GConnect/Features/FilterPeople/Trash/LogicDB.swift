//
//  LogicDB.swift
//  GConnect
//
//  Created by Dion Lamilga on 19/08/21.
//

import Foundation

extension FilterPeopleViewController{
    func storeFilter(){
        if let savedFilter = UserDefaults.standard.object(forKey: "filterLounge") as? Data{
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(FilterLounge.self, from: savedFilter){
                filter = loadedFilter
            }
        }
        
//        if filter?.statusFilter == true{
//            btnRemoveFilter.isHidden = false
//        }else{
//            btnRemoveFilter.isHidden = true
//        }
        
        arrayStatusRole = filter!.arrayRole
        
        let controller = filter!.arrayRole[0]
        let duelist = filter!.arrayRole[1]
        let initiator = filter!.arrayRole[2]
        let sentinel = filter!.arrayRole[3]
        
        if controller == true {
            self.setButtonRole(sender: btnDefensive)
        }
        if duelist == true{
            self.setButtonRole(sender: btnRecon)
        }
        if initiator == true{
            self.setButtonRole(sender: btnSupport)
        }
        if sentinel == true{
            self.setButtonRole(sender: btnOffensive)
        }
        txtFieldRank.text = filter?.rank
        txtFieldGender.text = filter?.gender
    }
    
    
    func setFilter(){
        if arrayStatusRole == [false, false, false, false]{
            showErrorMessage(msg: "Choose minimal 1 role")
        }else if txtFieldRank.text == "" || txtFieldGender.text == ""{
            showErrorMessage(msg: "Fill all data")
        }else{
            let dataFilter = FilterLounge(statusFilter: true, game: "Apex Legends", role: arrayStatusRole, rank: txtFieldRank.text!, gender: txtFieldGender.text!)
            let encoder = JSONEncoder()
            if let filter = try? encoder.encode(dataFilter){
                UserDefaults.standard.set(filter, forKey: "filterLounge")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func removeFilter(){
        let dataFilter = FilterLounge(statusFilter: false, game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
        let encoder = JSONEncoder()
        if let filter = try? encoder.encode(dataFilter){
            UserDefaults.standard.set(filter, forKey: "filterLounge")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func showErrorMessage(msg: String){
        errorMessage.isHidden = false
        errorMessage.text = msg
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector (self.hideWrongLabel), userInfo: nil, repeats: false)
    }
}
