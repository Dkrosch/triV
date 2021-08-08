//
//  FilterLoungeViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 31/07/21.
//

import UIKit

class FilterLoungeViewController: UIViewController {

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var btnSentinel: UIButton!
    @IBOutlet weak var btnInitiator: UIButton!
    @IBOutlet weak var btnController: UIButton!
    @IBOutlet weak var btnDuelist: UIButton!
    @IBOutlet weak var txtFieldRank: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var btnSetFilter: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var btnRemoveFilter: UIButton!
    
    let arrayDataRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "APEX Predator"]
    let arrayGender = ["♂️Male", "♀ Female", "All"]
    var arrayStatusRole:[Bool] = [true, true, true, true]
    var statusGame:[Bool] = [false, false, false]
    var selectedGames = ""
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    var games = Games.getData()
    var createloungeVC = CreateLoungeVC()
    
    var statusValo = 1
    var arrFilter: [FilterLounge]?
    var filter: FilterLounge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
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
        
        let nibCell = UINib(nibName: "GamesCollectionViewCell", bundle: nil)
        gamesCollectionView.register(nibCell, forCellWithReuseIdentifier: "GamesCellId")
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Set Filter"
        
        if let savedFilter = UserDefaults.standard.object(forKey: "filterLounge") as? Data{
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(FilterLounge.self, from: savedFilter){
                filter = loadedFilter
            }
        }
        
        if filter?.statusFilter == true{
            btnRemoveFilter.isHidden = false
        }else{
            btnRemoveFilter.isHidden = true
        }
        
        arrayStatusRole = filter!.arrayRole
        
        var controller = filter!.arrayRole[0]
        var duelist = filter!.arrayRole[1]
        var initiator = filter!.arrayRole[2]
        var sentinel = filter!.arrayRole[3]
        
        if controller == true {
            self.setButtonRole(sender: btnController)
        }
        if duelist == true{
            self.setButtonRole(sender: btnDuelist)
        }
        if initiator == true{
            self.setButtonRole(sender: btnInitiator)
        }
        if sentinel == true{
            self.setButtonRole(sender: btnSentinel)
        }
        txtFieldRank.text = filter?.rank
        txtFieldGender.text = filter?.gender
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
    
    @IBAction func btnRemoveFilterTapped(_ sender: Any) {
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
    
    @objc func hideWrongLabel(){
        self.errorMessage.isHidden = true
    }
}

extension FilterLoungeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        cell.lblGameName.text = games[indexPath.row].gameName
        cell.imgGame.image = games[indexPath.row].gameImage.getImage()
        cell.viewBackground.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        if indexPath.row+1 == statusValo{
            cell.viewBackground.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            cell.viewBackground.layer.borderWidth = 4
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGames = games[indexPath.row].gameName
        
        statusValo = indexPath.row + 1
        gamesCollectionView.reloadData()
        viewDidLoad()
    }
}

extension FilterLoungeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
