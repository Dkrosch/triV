//
//  DetailLoungeViewController.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit
import Firebase


class DetailLoungeViewController: UIViewController {
    
    //@IBOutlet
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var Game: UITextField!
    @IBOutlet weak var Rank: UITextField!
    @IBOutlet weak var roles: UICollectionView!
    @IBOutlet weak var DescriptionTextbox: UITextView!
    @IBOutlet weak var JoinLoungeButton: UIButton!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var genderLabelDesc: UILabel!
    //@IBOutlet weak var roleStackView: UIStackView!
    @IBOutlet weak var genderStackView: UIStackView!
    @IBOutlet weak var bawahStackView: UIStackView!
    
    @IBOutlet weak var stackViewButton: UIStackView!
    
    @IBOutlet weak var contraintStackKeDesc: NSLayoutConstraint!
    @IBOutlet weak var constraintCollectionKeDesc: NSLayoutConstraint!
    @IBOutlet weak var constraintStackKeRolesLabel: NSLayoutConstraint!
    
    @IBOutlet weak var sentinelButtonAttrib: UIButton!
    @IBOutlet weak var controllerButtonAttrib: UIButton!
    @IBOutlet weak var initiatorButtonAttrib: UIButton!
    @IBOutlet weak var duelistButtonAttrib: UIButton!
    
    
    var idLounge = ""
    var detailLoungeVM = DetailLoungeViewModel()
    let rank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Immortal", "Radiant"]
    let arrGender = ["♂️Male", "♀ Female", "All"]
    var dataLounge = [DetailLounge]()
    var jumlahDataMember = 0
    var masterLounge = ""
    var dataMember1 = [LoungeMember]()
    var pickerView = UIPickerView()
    var pickerView2 = UIPickerView()
    var arrDataLoungeMember: [LoungeMember] = []
    var arrDataLoungeMemberUnfilter: [String] = []
    
    var arrayStatusRole: [Bool] = [true, true, true, true]
    var createloungeVC = CreateLoungeVC()
    
    var status: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ID Lounge: \(idLounge)")
        
//        bawahStackView.isHidden = true
        stackViewButton.isHidden = true
        
        constraintCollectionKeDesc.constant = 20
        contraintStackKeDesc.constant = 20
        constraintStackKeRolesLabel.constant = 8
        
        Rank.layer.cornerRadius = 8
        Rank.layer.borderWidth = 2
        Rank.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        Rank.isUserInteractionEnabled = false
        
        gender.layer.cornerRadius = 8
        gender.layer.borderWidth = 2
        gender.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        
        Game.layer.cornerRadius = 8
        Game.layer.borderWidth = 2
        Game.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        Game.isUserInteractionEnabled = false
        
        DescriptionTextbox.layer.cornerRadius = 8
        DescriptionTextbox.isUserInteractionEnabled = false
        
        genderStackView.isHidden = true
        
        JoinLoungeButton.layer.cornerRadius = 8
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 1
        Rank.inputView = pickerView
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        gender.inputView = pickerView2
        
        let nibRoles = UINib(nibName: "\(RequirementExploreLoungeCollectionViewCell.self)", bundle: nil)
        roles.register(nibRoles, forCellWithReuseIdentifier: "cellContoh")
        
        CollectionView.register(DetailLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: DetailLoungeCollectionViewCell.identifier)
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        roles.delegate = self
        roles.dataSource = self
        
        self.view.addSubview(CollectionView)
        self.view.addSubview(roles)
        self.hideKeyboardWhenTappedAround()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.btnEditTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Detail Lounge"
        
        dataLounge = []
        dataMember1 = []
        
        detailLoungeVM.getData(id: idLounge){ data in
            for (index, item) in data.enumerated(){
                self.dataLounge.append(DetailLounge(game: data[index].game, title: data[index].title, desc: data[index].desc, idMemberLounge: data[index].idMemberLounge, idRequirementsLounge: data[index].idRequirementsLounge, documentId: self.idLounge, creatAt: data[index].creatAt, gender: data[index].gender, rank: data[index].rank))
            
                self.navigationItem.title = data[0].title
                self.Game.text = data[0].game
                self.Rank.text = data[0].rank
                self.DescriptionTextbox.text = data[0].desc
                self.genderLabelDesc.text = data[0].gender
                self.gender.text = data[0].gender
                
                var masterLounge = data[0].idMemberLounge[0]
                
                if data[0].idMemberLounge.contains(userID) {
                    self.JoinLoungeButton.isHidden = true
                }else{
                    self.navigationItem.rightBarButtonItem = nil
                }
                
                var controller = data[0].idRequirementsLounge[0]
                var duelist = data[0].idRequirementsLounge[1]
                var initiator = data[0].idRequirementsLounge[2]
                var sentinel = data[0].idRequirementsLounge[3]
                
                if controller == true {
                    self.setButtonRole(sender: self.controllerButtonAttrib)
                }
                if duelist == true{
                    self.setButtonRole(sender: self.duelistButtonAttrib)
                }
                if initiator == true{
                    self.setButtonRole(sender: self.initiatorButtonAttrib)
                }
                if sentinel == true{
                    self.setButtonRole(sender: self.sentinelButtonAttrib)
                }
                
                
                if data[0].idMemberLounge[0] == userID{
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.btnEditTapped))
                }
                
                DispatchQueue.main.async {
                    self.roles.reloadData()
                    //self.viewWillAppear(true)
                }
            }
            
            self.detailLoungeVM.getDataMember(idMember: self.dataLounge[0].idMemberLounge) { dataMember in
                
                for (index, item) in dataMember.enumerated() {
                    self.dataMember1.append(LoungeMember(idMember: dataMember[index].idMember, name: dataMember[index].name, rank: dataMember[index].rank))
                }

                DispatchQueue.main.async {
                    self.CollectionView.reloadData()
                }
            }
        }
    }
    
    func setButtonRole(sender: UIButton){
        sender.setImage(UIImage(named: "Checkmark_icon"), for: .normal)
        sender.semanticContentAttribute = .forceRightToLeft
    }
    
    @IBAction func buttonJoinLoungeTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Join Lounge" {
            var unfillMember = ""
            guard let userID = Auth.auth().currentUser?.uid else { return }
            if arrDataLoungeMemberUnfilter[1] == "" {unfillMember = "Member2"}
            else if arrDataLoungeMemberUnfilter[2] == "" {unfillMember = "Member3"}
            else if arrDataLoungeMemberUnfilter[3] == "" {unfillMember = "Member4"}
            else if arrDataLoungeMemberUnfilter[4] == "" {unfillMember = "Member5"}
            else if arrDataLoungeMemberUnfilter[5] == "" {unfillMember = "Member6"}
            else if arrDataLoungeMemberUnfilter[6] == "" {unfillMember = "Member7"}
            else if arrDataLoungeMemberUnfilter[7] == "" {unfillMember = "Member8"}
            else if arrDataLoungeMemberUnfilter[8] == "" {unfillMember = "Member9"}
            else if arrDataLoungeMemberUnfilter[9] == "" {unfillMember = "Member10"}
            detailLoungeVM.insertMember(idMember: userID, idLounge: idLounge, unfillMember: unfillMember)
            viewWillAppear(true)
        }else{
            let alert = UIAlertController(title: "Are you sure?", message: "Do your really want to delete this lounge? This process cannot be undone.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in
                self.detailLoungeVM.deleteLounge(idLounge: self.idLounge)
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnSentinelTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[3], sender: sender as! UIButton){ status in
            self.arrayStatusRole[3] = status
        }
        print(arrayStatusRole)
    }
    
    @IBAction func btnInitiatorTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[2], sender: sender as! UIButton){ status in
            self.arrayStatusRole[2] = status
        }
        print(arrayStatusRole)
    }
    
    @IBAction func btnControllerTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[0], sender: sender as! UIButton){ status in
            self.arrayStatusRole[0] = status
        }
        print(arrayStatusRole)
    }
    
    @IBAction func btnDuelistTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[1], sender: sender as! UIButton){ status in
            self.arrayStatusRole[1] = status
        }
        print(arrayStatusRole)
    }
    
    @objc func btnEditTapped(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(btnDoneTapped))
        JoinLoungeButton.isHidden = false
        JoinLoungeButton.layer.backgroundColor = UIColor.red.cgColor
        JoinLoungeButton.setTitle("Delete Lounge", for: .normal)
        JoinLoungeButton.setTitleColor(UIColor.white, for: .normal)
        
        Rank.layer.borderColor = UIColor.white.cgColor
        Rank.backgroundColor = UIColor.white
        Rank.textColor = UIColor.black
        Rank.isUserInteractionEnabled = true
        
        genderLabelDesc.isHidden = true
        gender.layer.borderColor = UIColor.white.cgColor
        gender.backgroundColor = UIColor.white
        gender.textColor = UIColor.black
        gender.isUserInteractionEnabled = true
        
        roles.isHidden = true
        stackViewButton.isHidden = false
        
        genderStackView.isHidden = false
        
//        contraintStackKeDesc.constant = 20
//        constraintCollectionKeDesc.constant = 20
//        constraintStackKeRolesLabel.constant = 20
        
        DescriptionTextbox.layer.borderColor = nil
        DescriptionTextbox.layer.backgroundColor = UIColor.white.cgColor
        DescriptionTextbox.textColor = UIColor.black
        DescriptionTextbox.isUserInteractionEnabled = true
        status = true
        CollectionView.reloadData()
    }
    
    @objc func btnDoneTapped(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.btnEditTapped))
        JoinLoungeButton.isHidden = true
        JoinLoungeButton.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5641875267, blue: 0.4353749454, alpha: 1)
        JoinLoungeButton.setTitle("Join Lounge", for: .normal)
        JoinLoungeButton.setTitleColor(#colorLiteral(red: 0.0931308046, green: 0.1756470799, blue: 0.3408471346, alpha: 1), for: .normal)
        
        Rank.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        Rank.backgroundColor = #colorLiteral(red: 0.1762152612, green: 0.223038137, blue: 0.3465815187, alpha: 1)
        Rank.textColor = UIColor.white
        Rank.isUserInteractionEnabled = false
        
        genderLabelDesc.isHidden = false
        gender.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        gender.backgroundColor = #colorLiteral(red: 0.1762152612, green: 0.223038137, blue: 0.3465815187, alpha: 1)
        gender.textColor = UIColor.white
        gender.isUserInteractionEnabled = false
        
        genderStackView.isHidden = true
        
        roles.isHidden = false
        stackViewButton.isHidden = true

//        contraintStackKeDesc.constant = 0
//        constraintCollectionKeDesc.constant = 20
//        constraintStackKeRolesLabel.constant = 0
        
        DescriptionTextbox.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        DescriptionTextbox.layer.backgroundColor = #colorLiteral(red: 0.1762152612, green: 0.223038137, blue: 0.3465815187, alpha: 1)
        DescriptionTextbox.textColor = UIColor.white
        DescriptionTextbox.isUserInteractionEnabled = false
        status = false
        
        if arrayStatusRole == [false, false, false, false]{
            print("Choose mininal 1 role")
        }else{
            detailLoungeVM.updateDataLounge(idLounge: idLounge, desc: DescriptionTextbox.text, rank: Rank.text!, role: arrayStatusRole, gender: gender.text!)
        }
        
        CollectionView.reloadData()
    }
}

extension DetailLoungeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == CollectionView{
            if dataMember1.count != 0 {
                var arrDataLoungeMember: [LoungeMember] = []
                
                for i in 0..<dataMember1.count{
                    arrDataLoungeMember = dataMember1
                }
                //print(arrDataLoungeMember[indexPath.row].idMember)
                
                if status == true{
                    let alert = UIAlertController(title: "Warning", message: "Are you sure you want kick this member?", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                        self.CollectionView.reloadData()
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true)
                }else{
                    print("")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.CollectionView{
            return dataMember1.count
        }else{
            var isiReq = 0
            var arrReq: [Bool]?
            let countableSet = NSCountedSet()
            
            if dataLounge.count != 0{
                var controller = dataLounge[0].idRequirementsLounge[0]
                var duelist = dataLounge[0].idRequirementsLounge[1]
                var initiator = dataLounge[0].idRequirementsLounge[2]
                var sentinel = dataLounge[0].idRequirementsLounge[3]
                
                arrayStatusRole = [controller, duelist, initiator, sentinel]
                arrDataLoungeMemberUnfilter = dataLounge[0].idMemberLounge
                arrReq = dataLounge[0].idRequirementsLounge
                
                arrReq?.forEach({ (item: Bool) in
                    countableSet.add(item)
                })
                isiReq = countableSet.count(for: true)
            }
            
            return isiReq + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.CollectionView{
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: DetailLoungeCollectionViewCell.identifier, for: indexPath) as! DetailLoungeCollectionViewCell
            
            for i in 0..<dataMember1.count{
                arrDataLoungeMember = dataMember1
            }
            
            if status == true{
                if dataLounge[0].idMemberLounge[0] == arrDataLoungeMember[indexPath.row].idMember{
                    cellA.kickButton.isHidden = true
                }else{
                    cellA.kickButton.isHidden = false
                }
            }else{
                cellA.kickButton.isHidden = true
            }
            
            cellA.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
            cellA.layer.borderWidth = 2
            cellA.layer.cornerRadius = 10
            cellA.background.layer.backgroundColor = #colorLiteral(red: 0.1662740707, green: 0.2231230438, blue: 0.3549886644, alpha: 1)
            cellA.nama.text = arrDataLoungeMember[indexPath.row].name
            cellA.role.text = arrDataLoungeMember[indexPath.row].rank
            
            for i in 0..<dataMember1.count{
                arrDataLoungeMember = dataMember1
            }
            
            var memberKe = dataLounge[0].idMemberLounge.firstIndex(of: arrDataLoungeMember[indexPath.row].idMember)!
            if dataLounge[0].idMemberLounge.contains(arrDataLoungeMember[indexPath.row].idMember){
                //print(memberKe + 1)
            }
            
            cellA.idLounge = idLounge
            cellA.idMember = ("\(memberKe + 1)")
            cellA.indx = indexPath
            cellA.delegate = self
            
            return cellA
        }else{
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContoh", for: indexPath) as! RequirementExploreLoungeCollectionViewCell
            var requirement = RequirementExploreLoungeCollectionViewCell()
            cellB.layer.cornerRadius = 10
            cellB.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
            cellB.layer.borderWidth = 2
            cellB.requirementExploreLoungeCellView.layer.backgroundColor = #colorLiteral(red: 0.1682771742, green: 0.2152610421, blue: 0.3345189095, alpha: 1)
        
            var arrRole: [Bool] = []
            var dataReq: [String] = []
            
            if dataLounge.count != 0 {
                arrRole = dataLounge[0].idRequirementsLounge
                
                if arrRole[0] == true{ dataReq.append("Controller") }
                if arrRole[1] == true{ dataReq.append("Duelist") }
                if arrRole[2] == true{ dataReq.append("Initiator") }
                if arrRole[3] == true{ dataReq.append("Sentinel") }
                dataReq.append(dataLounge[0].rank)
                
                cellB.requirementExploreLoungeCellLabel.text = dataReq[indexPath.row]
            }
            return cellB
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.CollectionView{
            return CGSize(width: 100, height: 140)
        }else{
            return CGSize(width: 100, height: 32)
        }
    }
}

extension DetailLoungeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return rank.count
        case 2:
            return arrGender.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return rank[row]
        case 2:
            return arrGender[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            Rank.text = rank[row]
            Rank.resignFirstResponder()
        case 2:
            gender.text = self.arrGender[row]
            gender.resignFirstResponder()
        default:
            return
        }
    }
}

extension DetailLoungeViewController: dataLounge{
    func tapped(indexMember: String, id: String, index: Int) {
        print("\(indexMember) + \(id)")
        self.dataMember1.remove(at: index)
        self.CollectionView.reloadData()
    }
}
