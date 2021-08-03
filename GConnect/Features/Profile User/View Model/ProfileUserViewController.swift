//
//  ProfileUserViewController.swift
//  GConnect
//
//  Created by Vincent on 29/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileUserViewController: UIViewController {
    private var collectionRef: CollectionReference!
    
    var dataUser = [ProfileData]()
    
    var dataachivement = [Achivement]()

    @IBOutlet weak var viewContentProfileUser: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameLabelProfileUser: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stackAboutMeTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        
        aboutMeTextField.isScrollEnabled = false
        aboutMeTextField.isEditable = false
        
        stackUsernameView.isHidden = true

        let nib = UINib(nibName: "\(AchievementProfileCollectionViewCell.self)", bundle: nil)
        achievementCollectionView.register(nib, forCellWithReuseIdentifier: "achievementCell" )
        
        achievementCollectionView.delegate = self
        achievementCollectionView.dataSource = self

        achievementCollectionView.isScrollEnabled = false
        
        achievementCollectionView.layer.borderWidth = 1
        achievementCollectionView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        
        viewContentHeightConstraint.constant = 766 + (achievementCollectionView.frame.size.height*10)
        
        achievementCollectionViewConstraintHeight.constant = achievementCollectionView.frame.size.height*10
        
        print(achievementCollectionView.frame.size.height)
        view.layoutIfNeeded()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        collectionRef = Firestore.firestore().collection("achievement")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDataAchivement()
        fetchDataProfile()
    }
    
    func fetchDataAchivement(){

        dataachivement = []
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        collectionRef.whereField("uid", isEqualTo: userID).getDocuments { snapshot, error in
            if let err = error{
                print(err)
            } else {
                for document in (snapshot?.documents)!{
                    let data = document.data()
                    let title = data["Title"] as? String ?? ""
                    let Desc = data["Desc"] as? String ?? ""
                    let image = data["Image"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    
                    let newData = Achivement(title: title, image: image, desc: Desc, uid: uid)
                    
                    self.dataachivement.append(newData)
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

    
    @objc func editTapped(){
        stackUsernameView.isHidden = false
        aboutMeTextField.isEditable = true
        genderLabel.isHidden = true
        
        stackTextFieldUsername.addBackground(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        print("mau edit bang")
    }
    
    @objc func doneTapped(){
        stackUsernameView.isHidden = true
        aboutMeTextField.isEditable = false
        
        genderLabel.isHidden = false
        
        stackTextFieldUsername.addBackground(color: #colorLiteral(red: 0.2309213281, green: 0.2924915552, blue: 0.4204188585, alpha: 1))
        
        updateDataProfile()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        usernameLabelProfileUser.reloadInputViews()
        print("selesai edit bang")
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
    
}

extension ProfileUserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataachivement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementProfileCollectionViewCell
        
        cell.titleLabelAchievement.text = dataachivement[indexPath.row].title
        cell.descriptionLabelAchievement.text = "Hali"
        return cell
    }
    
    
}

extension ProfileUserViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 148)
    }
}
