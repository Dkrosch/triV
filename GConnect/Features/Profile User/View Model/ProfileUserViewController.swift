//
//  ProfileUserViewController.swift
//  GConnect
//
//  Created by Vincent on 29/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileUserViewController: UIViewController, UINavigationControllerDelegate {
    private var collectionRef: CollectionReference!
    
    var dataUser = [ProfileData]()
    
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
//    @IBOutlet weak var aboutMeViewProfileUser: UIView!
//    @IBOutlet weak var aboutMeDescriptionLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var buttonLogoutProfileUser: UIButton!
    
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var achievementCollectionViewConstraintHeight: NSLayoutConstraint!
    
    var editButtonDiPencet = false
    var udahDiFetch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stackAboutMeTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        
        aboutMeTextField.isScrollEnabled = false
        aboutMeTextField.isEditable = false
        
        stackUsernameView.isHidden = true
        
        changeProfilePicButton.isHidden = true

        let nib = UINib(nibName: "\(AchievementProfileCollectionViewCell.self)", bundle: nil)
        achievementCollectionView.register(nib, forCellWithReuseIdentifier: "achievementCell" )
        
        
        //delegate
        achievementCollectionView.delegate = self
        achievementCollectionView.dataSource = self
        
        usernameTextField.delegate = self
        aboutMeTextField.delegate = self

        achievementCollectionView.isScrollEnabled = false
        
        achievementCollectionView.layer.borderWidth = 1
        achievementCollectionView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        
        print(achievementCollectionView.frame.size.height)
        view.layoutIfNeeded()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        collectionRef = Firestore.firestore().collection("achievement")
        
//        let test = convertImageToBase64(image: profilePicture.image!)
//
//        if let decodedData = Data(base64Encoded: test, options: .ignoreUnknownCharacters) {
//            let image = UIImage(data: decodedData)
//            self.imageTest.image = image
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDataAchivement()
        fetchDataProfile()
    }
    
    func fetchDataAchivement(){
        dataachivement = []
        
        guard let userID = Auth.auth().currentUser?.uid else { return }

        achievementCollectionView.reloadData()
        
        collectionRef.whereField("uid", isEqualTo: userID).getDocuments { snapshot, error in
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
                    
                }
                if self.udahDiFetch == false {
                    self.viewContentHeightConstraint.constant = 766 + (self.achievementCollectionView.frame.size.height*CGFloat(self.dataachivement.count))
                    self.achievementCollectionViewConstraintHeight.constant = self.achievementCollectionView.frame.size.height*CGFloat(self.dataachivement.count)
                    
                    self.udahDiFetch = true
                }
                self.achievementCollectionView.reloadData()

            }
        }
    }
    
    func addAchievement(){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        
        
//        db.collection("achievement").document().setData(["Desc": ])

    }
    
    func updateDataProfile(){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let username = usernameTextField.text
        let about = aboutMeTextField.text
        
        let db = Firestore.firestore()
        db.collection("users").document(userID).updateData(["About": about, "username": username]){ (error) in
            
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

        let reference = datas.collection("users").document(userID)
        reference.getDocument{ (document, err) in
            if let error = err{
                print(error)
            }else if let document = document, document.exists{
                let username = document.get("username") as! String
                let gender = document.get("gender") as! String
                let about = document.get("About") as! String
                let imageRank = document.get("imageRank") as! String
                let imageProfile = document.get("imageProfile") as! String
                let role = document.get("role") as! String
                let rank = document.get("rank") as! String
                let game = document.get("game") as! String
                let birthday = document.get("birthday") as! String

                let newData = ProfileData(username: username, game: game, gender: gender, rank: rank, role: role, birthday: birthday, imageProfile: imageProfile, desc: about, imageRank: imageRank)
                self.dataUser.append(newData)

                self.usernameLabelProfileUser.text = username
                self.aboutMeTextField.text = about


                if gender == "Male" {
                    self.genderLabel.text = ("♂️\(gender)")
                }else{
                    self.genderLabel.text = ("♀ \(gender)")
                }
            }
        }
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 1)!
        return imageData.base64EncodedString()
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
        stackUsernameView.isHidden = false
        aboutMeTextField.isEditable = true
        
        usernameLabelProfileUser.isHidden = true
        changeProfilePicButton.isHidden = false
        genderLabel.isHidden = true
        
        usernameTextField.text = usernameLabelProfileUser.text
        
        self.editButtonDiPencet = true
        achievementCollectionView.reloadData()
        
        aboutMeTextField.textColor = .black
        stackAboutMeTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        stackAboutMeTextField.layer.borderWidth = 0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        print("mau edit bang")
    }
    
    @objc func doneTapped(){
        stackUsernameView.isHidden = true
        aboutMeTextField.isEditable = false
        
        usernameLabelProfileUser.isHidden = false
        changeProfilePicButton.isHidden = true
        genderLabel.isHidden = false
        
        aboutMeTextField.textColor = .white
        stackAboutMeTextField.layer.backgroundColor = #colorLiteral(red: 0.2309213281, green: 0.2924915552, blue: 0.4204188585, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        
        self.editButtonDiPencet = false
        achievementCollectionView.reloadData()
        
        updateDataProfile()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        self.viewWillAppear(true)
        
        print("selesai edit bang")
        
//        var converted = convertImageToBase64(image: profilePicture.image!)
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//
//
//        let reference = Firestore.firestore().collection("users").document(userID).updateData(["imageProfile": converted]){ (error) in
//            if error != nil{
//                print("eror")
//            } else{
//                print("done")
//            }
//        }
        
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("log out")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
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
        }else{
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
