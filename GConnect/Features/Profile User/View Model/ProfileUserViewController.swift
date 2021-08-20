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

protocol AddAchievementTapped {
    func addAchievement(isTapped: Bool)
    func deleteAchievement(isDelete: Bool)
}

extension ProfileUserViewController: AddAchievementTapped{
    func deleteAchievement(isDelete: Bool) {
        statusDelete = isDelete
        if isDelete == true{
            achievementCollectionViewConstraintHeight.constant -= 148
            viewContentHeightConstraint.constant -= 148
            achievementCollectionView.reloadData()
        }
    }
    
    func addAchievement(isTapped: Bool) {
        statusTapped = isTapped
        if statusTapped == true {
            achievementCollectionView.frame.size.height += 148
            viewContentHeightConstraint.constant += 148
            achievementCollectionView.reloadData()
        }
    }
}

class ProfileUserViewController: UIViewController, UINavigationControllerDelegate {
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
    
    var collectionRef: CollectionReference!
    var dataUser = [ProfileData]()
    var defaults = UserDefaults.standard
    var dataachivement = [Achivement]()
    var editButtonDiPencet = false
    var udahDiFetch = false
    var statusVisitor = false
    var idUser = ""
    var idMemberVisitor = ""
    var imageProfileSelected: UIImage? = nil
    var statusTapped = false
    var statusDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfigure()

        let nib = UINib(nibName: "\(AchievementProfileCollectionViewCell.self)", bundle: nil)
        achievementCollectionView.register(nib, forCellWithReuseIdentifier: "achievementCell" )
        
        achievementCollectionView.delegate = self
        achievementCollectionView.dataSource = self
        achievementCollectionView.isUserInteractionEnabled = false
        
        usernameTextField.delegate = self
        aboutMeTextField.delegate = self
        
        print(statusTapped)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        collectionRef = Firestore.firestore().collection("achievement")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
    
    
    @IBAction func addAchivementTapped(_ sender: Any) {
        let showAchievement = UIStoryboard(name: "Add Achievement", bundle: nil)
        let vc = showAchievement.instantiateViewController(identifier: "addAcivement") as! AddAchievementViewController
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        print("LogOut guyss")
        logoutUserDefault()
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
        editOn()
        print("mau edit bang")
    }
    
    @objc func doneTapped(){
        finishEdit()
    }
}

extension ProfileUserViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let achievementEdit = UIStoryboard(name: "Edit Achievement", bundle: nil)
        let vc = achievementEdit.instantiateViewController(identifier: "editAchievement") as! EditAchievementViewController
        vc.configureCell(dataAchievement: dataachivement[indexPath.row])
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileUserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataachivement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementProfileCollectionViewCell
        DispatchQueue.main.async {
            cell.dataAchivement(achivement: self.dataachivement[indexPath.row])
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
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
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
