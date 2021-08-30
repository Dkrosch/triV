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

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var ChooseRoleLabel: UILabel!
    @IBOutlet weak var ErrorMessageLabel: UILabel!
    @IBOutlet weak var btnSentinel: UIButton!
    @IBOutlet weak var btnInitiator: UIButton!
    @IBOutlet weak var btnController: UIButton!
    @IBOutlet weak var btnDuelist: UIButton!
    @IBOutlet weak var DescriptionTextbox: UITextView!
    @IBOutlet weak var txtFieldRanked: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var txtLoungeTitle: UITextField!
    @IBOutlet weak var CreateButton: UIButton!
    
    let arrayDataRank = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "APEX Predator"]
    let arrayGender = ["♂️Male", "♀ Female", "All"]
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    var selectedRole: [Bool] = [false, false, false, false]
    var statusSentinel = false
    var statusInitiator = false
    var statusController = false
    var statusDuelist = false
    var createLoungeVM = CreateLoungeViewModel()
    var games = Games.getData()
    var selectedGame = ""
    var arrSelectedGame = [false, false, false]
    let gamesCellId = "GamesCellId"
    var statusValo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        ErrorMessageLabel.isHidden = true
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
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
        
        let nibCell = UINib(nibName: "GamesCollectionViewCell", bundle: nil)
        gamesCollectionView.register(nibCell, forCellWithReuseIdentifier: "GamesCellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
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
        createLoungeVM.createLoungeData(game: selectedGame, title: txtLoungeTitle.text!, role: selectedRole, rank: txtFieldRanked.text!, gender: txtFieldGender.text!, desc: DescriptionTextbox.text, uid: userID){ valid in
            if valid == "game" {
                self.showErrorMessage(message: "Choose 1 game")
            }else if valid == "title" {
                self.showErrorMessage(message: "Insert lounge title")
            }else if valid == "role" {
                self.showErrorMessage(message: "Select min 1 role")
            }else{
                let idLounge = valid
                let myGroup = DispatchGroup()
                var tokenUser: String?
                
                myGroup.enter()
                Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { document, error in
                    if error != nil{
                        print("error")
                    }else if let document = document, document.exists{
                        tokenUser = document.get("fcmToken") as? String ?? ""
                        //print("ini token \(tokenUser)")
                        myGroup.leave()
                    }
                }
                
                myGroup.notify(queue: .main) {
                    let urlString =  "https://iid.googleapis.com/iid/v1/\(tokenUser ?? "")/rel/topics/\(idLounge)"
                    let url = NSURL(string: urlString)!
                    let request = NSMutableURLRequest(url: url as URL)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.setValue("key=AAAAq2N3lx0:APA91bHx2aF5NuZzWCQDQRLBig-p9ayg1v-WzFFfhoWqglfchIW2B04esd4cXrfCGHGvowpUOjQyLDSL4goYKkVTC5QLveFTcaP-ogLdNtrJp5pZHymg-5HyHoZAE6b10sT62yVwutLl", forHTTPHeaderField: "Authorization")
                    
                    let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
                        do {
                            if let jsonData = data {
                                if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                                    NSLog("Received data:\n\(jsonDataDict))")
                                }
                            }
                        } catch let err as NSError {
                            print(err.debugDescription)
                        }
                    }
                    task.resume()
                }
                
//                DispatchQueue.main.async {
//                    print("ini token \(tokenUser)")
//                }
                
                
                
//                let urlString2 = "https://iid.googleapis.com/iid/info/nKctODamlM4:CKrh_PC8kIb7O...clJONHoA?details=true"
//                let url2 = NSURL(string: urlString2)!
//                let request2 = NSMutableURLRequest(url: url2 as URL)
//                request2.httpMethod = "GET"
//                request2.setValue("key=ewBBLOV68k4xtl8SisDIcv:APA91bGjgHo5L3cJ9LXsjs_PVb4y6Slml2ZNGIgPzW0Xc-QKJozyKyAtY_3zzfhhVsXbM_aaMfw9xKLpv9GebVHnPAogErCz4to-erBTuXI5YknyQFkEgUxv-FmuvrwkGspwXURttAXS", forHTTPHeaderField: "Authorization")
//                let task2 =  URLSession.shared.dataTask(with: request2 as URLRequest)  { (data, response, error) in
//                    do {
//                        if let jsonData = data {
//                            if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
//                                NSLog("Received data:\n\(jsonDataDict))")
//                            }
//                        }
//                    } catch let err as NSError {
//                        print(err.debugDescription)
//                    }
//                }
                //                task2.resume()
                
                self.goToDetail(idLounge: idLounge)
            }
        }
    }
    
    func goToDetail(idLounge: String){
        let showProfile = UIStoryboard(name: "DetailLounge", bundle: nil)
        let vc = showProfile.instantiateViewController(identifier: "detailLounge") as! DetailLoungeViewController
        vc.statusInfo = false
        vc.idLounge = idLounge
        vc.statusCreate = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showErrorMessage(message: String){
        ErrorMessageLabel.isHidden = false
        ErrorMessageLabel.text = message
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector (self.hideWrongLabel), userInfo: nil, repeats: false)
    }
    
    @objc func hideWrongLabel(){
        self.ErrorMessageLabel.isHidden = true
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


extension CreateLoungeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gamesCellId, for: indexPath) as! GamesCollectionViewCell
        cell.configureCellAvailabel(games: games[indexPath.row])
        
        if indexPath.row != 0 {
            cell.configureCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGame = games[indexPath.row].gameName
        
        let cell = collectionView.cellForItem(at: indexPath) as! GamesCollectionViewCell
        cell.viewBackground.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        cell.viewBackground.layer.borderWidth = 5
    }
}
