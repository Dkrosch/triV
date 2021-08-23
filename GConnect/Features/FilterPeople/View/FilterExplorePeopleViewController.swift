//
//  FilterExplorePeopleViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 19/08/21.
//

import UIKit

class FilterExplorePeopleViewController: UIViewController {
    
    @IBOutlet weak var btnDuelist: UIButton!
    @IBOutlet weak var btnInitiator: UIButton!
    @IBOutlet weak var btnController: UIButton!
    @IBOutlet weak var btnSentinel: UIButton!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var txtFieldRank: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var btnSetFilter: UIButton!
    @IBOutlet weak var btnRemoveFilter: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    let arrayDataRank = ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "APEX Predator"]
    let arrayGender = ["♂️Male", "♀ Female", "All"]
    var arrayStatusRole:[Bool] = [true, true, true, true]
    var statusGame:[Bool] = [false, false, false]
    var selectedGames = ""
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    var games = Games.getData()
    var createloungeVC = CreateLoungeVC()
    
    var statusValo = 1
    var arrFilter: [FilterPeople]?
    var filter: FilterPeople?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfigure()
        let nibCell = UINib(nibName: "GamesCollectionViewCell", bundle: nil)
        gameCollectionView.register(nibCell, forCellWithReuseIdentifier: "GamesCellId")
        self.hideKeyboardWhenTappedAround()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Set Filter"
        storeFilter()
    }
    
    func setButtonRole(sender: UIButton){
        sender.setImage(UIImage(named: "Checkmark_icon"), for: .normal)
        sender.semanticContentAttribute = .forceRightToLeft
    }
    
    @IBAction func btnSentinelTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[3], sender: sender as! UIButton){ status in
            self.arrayStatusRole[3] = status
        }
    }
    
    @IBAction func btnInitiatorTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[2], sender: sender as! UIButton){ status in
            self.arrayStatusRole[2] = status
        }
    }
    
    @IBAction func btnControllerTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[0], sender: sender as! UIButton){ status in
            self.arrayStatusRole[0] = status
        }
    }
    
    @IBAction func btnDuelistTapped(_ sender: Any) {
        createloungeVC.changeStatusRole(status: arrayStatusRole[1], sender: sender as! UIButton){ status in
            self.arrayStatusRole[1] = status
        }
    }
    
    @IBAction func btnSetFilterTapped(_ sender: Any) {
        setFilter()
    }
    
    @IBAction func btnRemoveFilterTapped(_ sender: Any) {
        removeFilter()
    }
    
    @objc func hideWrongLabel(){
        self.errorMessage.isHidden = true
    }
}

extension FilterExplorePeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: 104)
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

extension FilterExplorePeopleViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
            txtFieldRank.text = self.arrayDataRank[row]
            txtFieldRank.resignFirstResponder()
        case 2:
            txtFieldGender.text = self.arrayGender[row]
            txtFieldGender.resignFirstResponder()
        default:
            return
        }
    }
}
