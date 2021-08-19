//
//  FilterPeopleViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 19/08/21.
//

import UIKit

class FilterPeopleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
   let labelName: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
    }()
    
    let labelRole: UILabel = {
     let label = UILabel()
     label.textAlignment = .center
     label.numberOfLines = 0
     return label
     }()
    
    let labelRank: UILabel = {
     let label = UILabel()
     label.textAlignment = .center
     label.numberOfLines = 0
     return label
     }()
    
    let labelGender: UILabel = {
     let label = UILabel()
     label.textAlignment = .center
     label.numberOfLines = 0
     return label
     }()
    
    let buttonSetFilter: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.990685761, green: 0.5867353678, blue: 0.417869091, alpha: 1)
        return button
    }()
    
    let buttonRemoveFilter: UIButton = UIButton()
    
    let errorMessage: UILabel = {
     let label = UILabel()
     label.textAlignment = .center
     label.numberOfLines = 0
     return label
     }()
    
    let pickerGender: UIPickerView = UIPickerView()
    let pickerRank: UIPickerView = UIPickerView()
    
    let txtFieldRank: UITextField = UITextField()
    let txtFieldGender: UITextField = UITextField()
    
    let btnOffensive: UIButton = UIButton()
    let btnDefensive: UIButton = UIButton()
    let btnSupport: UIButton = UIButton()
    let btnRecon: UIButton = UIButton()
    
    var collectionViewGames: UICollectionView?
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let dataGender = ["♂️Male", "♀ Female", "All"]
    let dataRank = ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "APEX Predator"]
    var arrayStatusRole:[Bool] = [true, true, true, true]
    var createloungeVC = CreateLoungeVC()
    var games = Games.getData()
    var selectedGames = ""
    
    var statusValo = 1
    var arrFilter: [FilterLounge]?
    var filter: FilterLounge?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1109148934, green: 0.1709802151, blue: 0.3285216391, alpha: 1)
        collectionViewGames?.delegate = self
        collectionViewGames?.dataSource = self
        
        let nibCell = UINib(nibName: "GamesCollectionViewCell", bundle: nil)
        collectionViewGames?.register(nibCell, forCellWithReuseIdentifier: "GamesCellId")
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storeFilter()
    }
    
    func configureView(){
        labelName.frame = CGRect(x: 22, y: 118, width: 130, height: 25)
        labelName.text = "Select Games"
        labelName.font = UIFont.systemFont(ofSize: 21)
        labelName.textColor = .white
        view.addSubview(labelName)
        
        labelRole.frame = CGRect(x: 22, y: 282, width: 190, height: 25)
        labelRole.text = "Role That You Need"
        labelRole.font = UIFont.systemFont(ofSize: 21)
        labelRole.textColor = .white
        view.addSubview(labelRole)
        
        labelRank.frame = CGRect(x: 22, y: 418, width: 50, height: 25)
        labelRank.text = "Rank"
        labelRank.font = UIFont.systemFont(ofSize: 21)
        labelRank.textColor = .white
        view.addSubview(labelRank)
        
        labelGender.frame = CGRect(x: 22, y: 511, width: 70, height: 25)
        labelGender.text = "Gender"
        labelGender.font = UIFont.systemFont(ofSize: 21)
        labelGender.textColor = .white
        view.addSubview(labelGender)
        
        buttonSetFilter.frame = CGRect(x: 20, y: 722, width: 358, height: 50)
        buttonSetFilter.setTitle("Set Filter", for: .normal)
        buttonSetFilter.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        buttonSetFilter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonSetFilter.layer.cornerRadius = 10
        buttonSetFilter.addTarget(self, action: #selector(btnSetFilterTapped), for: .touchUpInside)
        view.addSubview(buttonSetFilter)
        
        pickerGender.delegate = self as UIPickerViewDelegate
        pickerGender.dataSource = self as UIPickerViewDataSource
        pickerGender.tag = 2
        
        pickerRank.delegate = self as UIPickerViewDelegate
        pickerRank.dataSource = self as UIPickerViewDataSource
        pickerRank.tag = 1
        
        txtFieldRank.frame = CGRect(x: 20, y: 448, width: 358, height: 40)
        txtFieldRank.placeholder = "Rank"
        txtFieldRank.font = UIFont.systemFont(ofSize: 21)
        txtFieldRank.backgroundColor = .white
        txtFieldRank.layer.cornerRadius = 10
        txtFieldRank.inputView = pickerRank
        view.addSubview(txtFieldRank)
        
        txtFieldGender.frame = CGRect(x: 20, y: 541, width: 358, height: 40)
        txtFieldGender.placeholder = "Gender"
        txtFieldGender.font = UIFont.systemFont(ofSize: 21)
        txtFieldGender.backgroundColor = .white
        txtFieldGender.layer.cornerRadius = 10
        txtFieldGender.inputView = pickerGender
        view.addSubview(txtFieldGender)
        
        btnOffensive.frame = CGRect(x: 20, y: 316, width: 105, height: 33)
        btnOffensive.setTitle("Offensive", for: .normal)
        btnOffensive.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnOffensive.backgroundColor = .white
        btnOffensive.layer.cornerRadius = 10
        btnOffensive.addTarget(self, action: #selector(btnOffecsiveTapped), for: .touchUpInside)
        view.addSubview(btnOffensive)
        
        btnDefensive.frame = CGRect(x: 145, y: 316, width: 105, height: 33)
        btnDefensive.setTitle("Defensive", for: .normal)
        btnDefensive.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnDefensive.backgroundColor = .white
        btnDefensive.layer.cornerRadius = 10
        btnDefensive.addTarget(self, action: #selector(btnDefensiveTapped), for: .touchUpInside)
        view.addSubview(btnDefensive)
        
        btnSupport.frame = CGRect(x: 20, y: 364, width: 105, height: 33)
        btnSupport.setTitle("Support", for: .normal)
        btnSupport.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnSupport.backgroundColor = .white
        btnSupport.layer.cornerRadius = 10
        btnSupport.addTarget(self, action: #selector(btnSupportTapped), for: .touchUpInside)
        view.addSubview(btnSupport)
        
        btnRecon.frame = CGRect(x: 145, y: 364, width: 105, height: 33)
        btnRecon.setTitle("Recon", for: .normal)
        btnRecon.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnRecon.backgroundColor = .white
        btnRecon.layer.cornerRadius = 10
        btnRecon.addTarget(self, action: #selector(btnReconTapped), for: .touchUpInside)
        view.addSubview(btnRecon)
        
        errorMessage.frame = CGRect(x: 20, y: 610, width: 358, height: 33)
        errorMessage.text = "Error"
        errorMessage.textColor = .red
        errorMessage.isHidden = true
        view.addSubview(errorMessage)
        
        buttonRemoveFilter.frame = CGRect(x: 20, y: 660, width: 358, height: 50)
        buttonRemoveFilter.setTitle("Remove Filter", for: .normal)
        buttonRemoveFilter.setTitleColor(#colorLiteral(red: 0.990685761, green: 0.5867353678, blue: 0.417869091, alpha: 1), for: .normal)
        buttonRemoveFilter.backgroundColor = .clear
        buttonRemoveFilter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonRemoveFilter.layer.borderColor = #colorLiteral(red: 0.990685761, green: 0.5867353678, blue: 0.417869091, alpha: 1)
        buttonRemoveFilter.layer.borderWidth = 2
        buttonRemoveFilter.layer.cornerRadius = 10
        buttonRemoveFilter.isHidden = true
        buttonRemoveFilter.addTarget(self, action: #selector(btnRemoveFilterTapped), for: .touchUpInside)
        view.addSubview(buttonRemoveFilter)
        
        layout.scrollDirection = .horizontal
       layout.itemSize = CGSize(width: 70, height: 70)
        collectionViewGames?.backgroundColor = UIColor.white
        collectionViewGames = UICollectionView(frame: CGRect(x: 22, y: 150, width: 350, height: 125), collectionViewLayout: layout)
        collectionViewGames?.backgroundColor = .white
        view.addSubview(collectionViewGames ?? UICollectionView())
    }
    
    @objc func btnSetFilterTapped(){
       // setFilter()
    }
    
    @objc func btnRemoveFilterTapped(){
       // removeFilter()
    }
    
    @objc func hideWrongLabel(){
        self.errorMessage.isHidden = true
    }
    
    @objc func btnOffecsiveTapped(sender: UIButton!) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[3], sender: sender!){ status in
            self.arrayStatusRole[3] = status
        }
    }
    
    @objc func btnDefensiveTapped(sender: UIButton!) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[0], sender: sender!){ status in
            self.arrayStatusRole[0] = status
        }
    }
    
    @objc func btnSupportTapped(sender: UIButton!) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[2], sender: sender!){ status in
            self.arrayStatusRole[2] = status
        }
    }
    
    @objc func btnReconTapped(sender: UIButton!) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[1], sender: sender!){ status in
            self.arrayStatusRole[1] = status
        }
    }
    
    func setButtonRole(sender: UIButton){
        sender.setImage(UIImage(named: "Checkmark_icon"), for: .normal)
        sender.semanticContentAttribute = .forceRightToLeft
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return dataRank.count
        case 2:
            return dataGender .count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return dataRank[row]
        case 2:
            return dataGender[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            txtFieldRank.text = self.dataRank[row]
            txtFieldRank.resignFirstResponder()
        case 2:
            txtFieldGender.text = self.dataGender[row]
            txtFieldGender.resignFirstResponder()
        default:
            return
        }
    }
}

extension FilterPeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(games.count)
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCellId", for: indexPath) as! GamesCollectionViewCell
        cell.configureCellAvailabel(games: games[indexPath.row])
        if indexPath.row != 0 {
            cell.configureCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGames = games[indexPath.row].gameName
        let cell = collectionView.cellForItem(at: indexPath) as! GamesCollectionViewCell
        cell.viewBackground.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        cell.viewBackground.layer.borderWidth = 5
    }
    
}
