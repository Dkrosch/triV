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
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderLabelDesc: UILabel!
    @IBOutlet weak var viewRole: UIView!
    @IBOutlet weak var RoleButton: UIButton!
    
    var idLounge = ""
    var detailLoungeVM = DetailLoungeViewModel()
    let rank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Immortal", "Radiant"]
    var dataLounge = [DetailLounge]()
    var jumlahDataMember = 0
    var dataMember1 = [LoungeMember]()
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ID Lounge: \(idLounge)")
        
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
        
        JoinLoungeButton.layer.cornerRadius = 8
        
        pickerView.delegate = self
        pickerView.dataSource = self
        Rank.inputView = pickerView
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        viewRole.isHidden = true
        gender.isHidden = true
        genderLabel.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Detail Lounge"
        
        detailLoungeVM.getData(id: idLounge){ data in
            for (index, item) in data.enumerated(){
                self.dataLounge.append(DetailLounge(game: data[index].game, title: data[index].title, desc: data[index].desc, idMemberLounge: data[index].idMemberLounge, idRequirementsLounge: data[index].idRequirementsLounge, documentId: self.idLounge, creatAt: data[index].creatAt, gender: data[index].gender, rank: data[index].rank))
            
                self.navigationItem.title = data[0].title
                self.Game.text = data[0].game
                self.Rank.text = data[0].rank
                self.DescriptionTextbox.text = data[0].desc
                
                if data[0].idMemberLounge[0] == userID{
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.btnEditTapped))
                }
                
                DispatchQueue.main.async {
                    self.roles.reloadData()
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
    
    @objc func btnEditTapped(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(btnDoneTapped))
        JoinLoungeButton.layer.backgroundColor = UIColor.red.cgColor
        JoinLoungeButton.setTitle("Delete Lounge", for: .normal)
        JoinLoungeButton.setTitleColor(UIColor.white, for: .normal)
        
        Rank.layer.borderColor = UIColor.white.cgColor
        Rank.backgroundColor = UIColor.white
        Rank.textColor = UIColor.black
        Rank.isUserInteractionEnabled = true
        
        gender.isHidden = false
        genderLabel.isHidden = false
        genderLabelDesc.isHidden = true
        
        DescriptionTextbox.layer.borderColor = nil
        DescriptionTextbox.layer.backgroundColor = UIColor.white.cgColor
        DescriptionTextbox.textColor = UIColor.black
        DescriptionTextbox.isUserInteractionEnabled = true
    }
    
    @objc func btnDoneTapped(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.btnEditTapped))
        JoinLoungeButton.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5641875267, blue: 0.4353749454, alpha: 1)
        JoinLoungeButton.setTitle("Join Lounge", for: .normal)
        JoinLoungeButton.setTitleColor(#colorLiteral(red: 0.0931308046, green: 0.1756470799, blue: 0.3408471346, alpha: 1), for: .normal)
        
        Rank.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        Rank.backgroundColor = #colorLiteral(red: 0.1762152612, green: 0.223038137, blue: 0.3465815187, alpha: 1)
        Rank.textColor = UIColor.white
        Rank.isUserInteractionEnabled = false
        genderLabelDesc.isHidden = false
        
        DescriptionTextbox.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        DescriptionTextbox.layer.backgroundColor = #colorLiteral(red: 0.1762152612, green: 0.223038137, blue: 0.3465815187, alpha: 1)
        DescriptionTextbox.textColor = UIColor.white
        DescriptionTextbox.isUserInteractionEnabled = false
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
                print(arrDataLoungeMember[indexPath.row].idMember)
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
                arrReq = dataLounge[0].idRequirementsLounge
                arrReq?.forEach({ (item: Bool) in
                    countableSet.add(item)
                })
                isiReq = countableSet.count(for: true)
            }
            
            return isiReq + 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.CollectionView{
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: DetailLoungeCollectionViewCell.identifier, for: indexPath) as! DetailLoungeCollectionViewCell
            
            cellA.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
            cellA.layer.borderWidth = 2
            cellA.layer.cornerRadius = 10
            cellA.background.layer.backgroundColor = #colorLiteral(red: 0.1662740707, green: 0.2231230438, blue: 0.3549886644, alpha: 1)
            
            var arrDataLoungeMember: [LoungeMember] = []
            
            for i in 0..<dataMember1.count{
                arrDataLoungeMember = dataMember1
            }
            
            cellA.nama.text = arrDataLoungeMember[indexPath.row].name
            cellA.role.text = arrDataLoungeMember[indexPath.row].rank
            
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
                dataReq.append(dataLounge[0].gender)
                
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
        return rank.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rank[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Rank.text = rank[row]
        Rank.resignFirstResponder()
    }
}
