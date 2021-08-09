//
//  ProfileUserViewController.swift
//  GConnect
//
//  Created by Vincent on 29/07/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ProfileUserViewController: UIViewController, UINavigationControllerDelegate {
    private var collectionRef: CollectionReference!
    
    var dataUser = [ProfileData]()
    var defaults = UserDefaults.standard
    var dataachivement = [Achivement]()

    @IBOutlet weak var viewContentProfileUser: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var usernameLabelProfileUser: UILabel!
    @IBOutlet weak var changeProfilePicButton: UIButton!
    
    @IBOutlet weak var stackAboutMeTextField: UIStackView!
    @IBOutlet weak var aboutMeTextField: UITextView!
    
    @IBOutlet weak var stackTextFieldUsername: UIStackView!
    @IBOutlet weak var stackUsernameView: UIStackView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var btnAddAchievement: UIButton!
    //Stats View
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var statsHeaderView: UIView!
    @IBOutlet weak var gameIcon: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gamerNameLabel: UILabel!
    @IBOutlet weak var levelTitleLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var selectedlegendTitleLabel: UILabel!
    @IBOutlet weak var legendNameLabel: UILabel!
    @IBOutlet weak var legendImage: UIImageView!
    @IBOutlet weak var roleTitleLabel: UILabel!
    @IBOutlet weak var roleUserLabel: UILabel!
    @IBOutlet weak var statsView1: UIView!
    @IBOutlet weak var statsView2: UIView!
    @IBOutlet weak var statsView3: UIView!
    @IBOutlet weak var valueStatsLabel1: UILabel!
    @IBOutlet weak var statsTitleLabel1: UILabel!
    @IBOutlet weak var valueStatsLabel2: UILabel!
    @IBOutlet weak var statsTitleLable2: UILabel!
    @IBOutlet weak var valueStatsLabel3: UILabel!
    @IBOutlet weak var statsTitleLabel3: UILabel!
    @IBOutlet weak var rankTitleLabel: UILabel!
    @IBOutlet weak var userRankLabel: UILabel!
    @IBOutlet weak var rankIconImage: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var buttonLogoutProfileUser: UIButton!
    
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var achievementCollectionViewConstraintHeight: NSLayoutConstraint!
    
    var editButtonDiPencet = false
    var udahDiFetch = false
    var statusVisitor = false
    var idUser = ""
    var idMemberVisitor = ""
    var imageProfileSelected: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stackAboutMeTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        
//        aboutMeTextField.isScrollEnabled = true
        aboutMeTextField.isEditable = false
        
        stackUsernameView.isHidden = true
        
        changeProfilePicButton.isHidden = true

        let nib = UINib(nibName: "\(AchievementProfileCollectionViewCell.self)", bundle: nil)
        achievementCollectionView.register(nib, forCellWithReuseIdentifier: "achievementCell" )
        
        aboutMeTextField.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        achievementCollectionView.delegate = self
        achievementCollectionView.dataSource = self
        
        usernameTextField.delegate = self
        aboutMeTextField.delegate = self
        
        statsView.layer.borderWidth = 1
        statsView.layer.borderColor = UIColor(named: "Vivid Tangerine")?.cgColor
        statsView.layer.cornerRadius = 10.0
        statsView.layer.masksToBounds = true
        
        statsView1.layer.borderWidth = 2
        statsView1.layer.borderColor = UIColor(named: "Red")?.cgColor
        statsView2.layer.borderWidth = 2
        statsView2.layer.borderColor = UIColor(named: "Red")?.cgColor
        statsView3.layer.borderWidth = 2
        statsView3.layer.borderColor = UIColor(named: "Red")?.cgColor

        achievementCollectionView.isScrollEnabled = true
        achievementCollectionView.isUserInteractionEnabled = true
        
        achievementCollectionView.layer.borderWidth = 1
        achievementCollectionView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        
        buttonLogoutProfileUser.layer.cornerRadius = 8
        
        print(achievementCollectionView.frame.size.height)
        view.layoutIfNeeded()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        collectionRef = Firestore.firestore().collection("achievement")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        idUser = userID
        
        if statusVisitor == true{
            idUser = idMemberVisitor
            self.navigationItem.rightBarButtonItem = nil
            buttonLogoutProfileUser.isHidden = true
            btnAddAchievement.isHidden = true
        }
        
        fetchDataProfile()
        fetchDataAchivement()
    }
    
    func fetchDataAchivement(){
        dataachivement = []

        achievementCollectionView.reloadData()
        
        collectionRef.whereField("uid", isEqualTo: idUser).addSnapshotListener({ snapshot, error in
            if let err = error{
                print(err)
            } else {
                for document in (snapshot?.documents)!{
                    let data = document.data()
                    let id = document.documentID
                    let title = data["Title"] as? String ?? ""
                    let Desc = data["Desc"] as? String ?? ""
                    let image = data["Image"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    
                    let newData = Achivement(title: title, image: image, desc: Desc, uid: uid, data: id)
                    
                    self.dataachivement.append(newData)
                    print(self.dataachivement.count)
                }
                
                DispatchQueue.main.async {
                    self.achievementCollectionView.reloadData()
                }
                
                if self.udahDiFetch == false {
                    self.achievementCollectionViewConstraintHeight.constant = self.achievementCollectionView.frame.size.height*CGFloat(self.dataachivement.count)
                    self.viewContentHeightConstraint.constant = 816 + self.achievementCollectionViewConstraintHeight.constant
                    self.udahDiFetch = true
                }
                self.achievementCollectionView.reloadData()
            }
        })
    }
    
    func updateDataProfile(){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let username = usernameTextField.text
        let about = aboutMeTextField.text
        
        let db = Firestore.firestore()
        db.collection("users").document(idUser).updateData(["About": about, "username": username]){ (error) in
            
            if error != nil{
                print("eror")
            } else{
                print("done")
            }
        }
    }
    
    func fetchDataProfile(){
        let datas = Firestore.firestore()

        guard let userID = Auth.auth().currentUser?.uid else { return }

        let reference = datas.collection("users").document(idUser)
        reference.getDocument{ (document, err) in
            if let error = err{
                print(error)
            }else if let document = document, document.exists{
                let username = document.get("username") as! String
                let gender = document.get("gender") as! String
                let about = document.get("About") as! String
                let imageRank = document.get("imageRank") as! String
                let imageProfile = document.get("imageProfile") as! String
                self.profileimageURL(urlKey: document.get("imageProfile") as! String)
                let role = document.get("role") as! String
                let rank = document.get("rank") as! String
                let game = document.get("game") as! String
                let birthday = document.get("birthday") as! String
                let gamerUname = document.get("gamerUname") as! String

                let newData = ProfileData(username: username, game: game, gender: gender, rank: rank, role: role, birthday: birthday, imageProfile: imageProfile, desc: about, imageRank: imageRank, gamerUname: gamerUname)
                self.dataUser.append(newData)

                self.usernameLabelProfileUser.text = username
                self.aboutMeTextField.text = about
                self.roleUserLabel.text = role


                if gender == "Male" {
                    self.genderLabel.text = ("♂️\(gender)")
                }else{
                    self.genderLabel.text = ("♀ \(gender)")
                }
                
                ApiService.getDatas(url: "https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=\(gamerUname)&auth=i6Xau6J5JvKzMy9J3LXI") { (response, error) in
                    if response != nil {
                        if let responseFromAPI = response {
                            print(responseFromAPI.global?.name)
                            self.gamerNameLabel.text = responseFromAPI.global?.name!
                            self.userLevelLabel.text = ("\(responseFromAPI.global!.level!)")
                            self.legendNameLabel.text = responseFromAPI.legends?.selected?.LegendName!
                            self.userRankLabel.text = responseFromAPI.global?.rank?.rankName!
                            self.imageURL(urlKey: (responseFromAPI.legends?.selected?.ImgAssets?.icon!)!)
                            self.valueStatsLabel1.text = ("\(responseFromAPI.total?.damage?.value ?? 0)")
                            self.valueStatsLabel2.text = ("\(responseFromAPI.total?.kills?.value ?? 0)")
                            self.valueStatsLabel3.text = ("\(responseFromAPI.total?.headshots?.value ?? 0)")
                            self.rankIconImage.image = UIImage(named: (responseFromAPI.global?.rank?.rankName!)!)
                        }
                    }
                } failCompletion: { error in
                    print(error)
                }
            }
        }
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        print("LogOut guyss")
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do{
                var dataFilter = FilterLounge(statusFilter: false, game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
                let encoder = JSONEncoder()
                if let filter = try? encoder.encode(dataFilter){
                    UserDefaults.standard.set(filter, forKey: "filterLounge")
                }
                
                self.defaults.set(false, forKey: "isUserSignedIn")
                self.defaults.synchronize()
                let backLogin = UIStoryboard(name: "Login", bundle: nil)
                let vc = backLogin.instantiateViewController(identifier: "loginView") as! UINavigationController
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            } catch let err{
                print("error")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imageURL(urlKey: String){
        if let url = URL(string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.legendImage.image = UIImage(data: data)
            } catch let err{
                print("error")
            }
        }
    }
    
    func profileimageURL(urlKey: String){
        if let url = URL(string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.profilePicture.image = UIImage(data: data)
            } catch let err{
                print("error")
            }
        }
    }
    
    func uploadImageToStorage(){
            let storage = Storage.storage().reference()
            let db = Firestore.firestore()

            guard let userID = Auth.auth().currentUser?.uid else { return }

            guard let imageSelected = self.imageProfileSelected else{
                return
            }

            guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                return
            }
        
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"

            let photoRef = storage.child("profile").child(userID)

            photoRef.putData(imageData, metadata: metadata) { StorageMetadata, error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }

                photoRef.downloadURL { url, error in
                    if let metaImageURL = url?.absoluteString{
                        db.collection("users").document(userID).updateData(["imageProfile": metaImageURL]){ (error) in
                            if error != nil{
                                print("eror")
                            } else{
                                print("berhasil upload image")
                            }
                        }
                    }
                }
            }
        }

    @IBAction func changeProfilePicButtonTapped(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
        }
    }
    
    @objc func editTapped(){
        self.tabBarController?.tabBar.isHidden = true
        
        stackUsernameView.isHidden = false
        aboutMeTextField.isEditable = true
        
        usernameLabelProfileUser.isHidden = true
        changeProfilePicButton.isHidden = false
        genderLabel.isHidden = true
        buttonLogoutProfileUser.isHidden = true
        
        achievementCollectionView.isUserInteractionEnabled = true
        
        usernameTextField.text = usernameLabelProfileUser.text
        
        self.editButtonDiPencet = true
        achievementCollectionView.reloadData()
        
        aboutMeTextField.textColor = .black
        stackAboutMeTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        stackAboutMeTextField.layer.borderWidth = 0
        
        btnAddAchievement.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        print("mau edit bang")
    }
    
    @objc func doneTapped(){
        self.tabBarController?.tabBar.isHidden = false
        stackUsernameView.isHidden = true
        aboutMeTextField.isEditable = false
        
        btnAddAchievement.isHidden = false
        
        usernameLabelProfileUser.isHidden = false
        changeProfilePicButton.isHidden = true
        genderLabel.isHidden = false
        buttonLogoutProfileUser.isHidden = false
        
        achievementCollectionView.isUserInteractionEnabled = false
        
        aboutMeTextField.textColor = .white
        stackAboutMeTextField.layer.backgroundColor = #colorLiteral(red: 0.2309213281, green: 0.2924915552, blue: 0.4204188585, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        
        self.editButtonDiPencet = false
        achievementCollectionView.reloadData()
        
        updateDataProfile()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        print("selesai edit bang")
        
        uploadImageToStorage()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false){ (timer) in
            self.viewWillAppear(true)
        }
    }
}

extension ProfileUserViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let achievementEdit = UIStoryboard(name: "Edit Achievement", bundle: nil)
        let vc = achievementEdit.instantiateViewController(identifier: "editAchievement") as! EditAchievementViewController
        vc.desc = dataachivement[indexPath.row].desc
        vc.titleAchievement = dataachivement[indexPath.row].title
        vc.uid = dataachivement[indexPath.row].data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileUserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataachivement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementProfileCollectionViewCell
        
        cell.titleLabelAchievement.text = dataachivement[indexPath.row].title
        cell.descriptionLabelAchievement.text = dataachivement[indexPath.row].desc
        
        if let url = URL(string: dataachivement[indexPath.row].image){
            do{
                let data = try Data(contentsOf: url)
                cell.imageViewAchievement.image = UIImage(data: data)
            } catch let err{
                print("error")
            }
        }

        if self.editButtonDiPencet == true {
            cell.buttonEdit.isHidden = false
        }else{
            cell.buttonEdit.isHidden = true
        }
        
        return cell
    }
}

extension ProfileUserViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 148)
    }
}

extension ProfileUserViewController: UITextViewDelegate, UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textView.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        // make sure the result is under 16 characters
        return updatedText.count <= 100
    }
}

extension ProfileUserViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profilePicture.image = image
            imageProfileSelected = image
        }else{
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
