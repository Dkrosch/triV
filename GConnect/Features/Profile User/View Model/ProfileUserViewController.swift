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
    
    
    @IBOutlet weak var changePicButton: UIButton!
    
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var achievementCollectionViewConstraintHeight: NSLayoutConstraint!
    
    var editButtonDiPencet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stackAboutMeTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        stackAboutMeTextField.layer.borderWidth = 1
        
        aboutMeTextField.isScrollEnabled = false
        aboutMeTextField.isEditable = false
        
        stackUsernameView.isHidden = true
        changePicButton.isHidden = true

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
        
        viewContentHeightConstraint.constant = 766 + (achievementCollectionView.frame.size.height*10)
        
        achievementCollectionViewConstraintHeight.constant = achievementCollectionView.frame.size.height*10
        
        print(achievementCollectionView.frame.size.height)
        view.layoutIfNeeded()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        fetchDataProfile()
    }
    
    @objc func editTapped(){
        stackUsernameView.isHidden = false
        aboutMeTextField.isEditable = true
        
        usernameLabelProfileUser.isHidden = true
        genderLabel.isHidden = true
        changePicButton.isHidden = false
        
        stackAboutMeTextField.layer.borderWidth = 0
        
        aboutMeTextField.textColor = .black
        stackAboutMeTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        self.editButtonDiPencet = true
        print(self.editButtonDiPencet)
        
        achievementCollectionView.reloadData()
        
        print("mau edit bang")
    }
    
    @objc func doneTapped(){
        stackUsernameView.isHidden = true
        aboutMeTextField.isEditable = false
        
        usernameLabelProfileUser.isHidden = false
        changePicButton.isHidden = true
        genderLabel.isHidden = false
        
        stackAboutMeTextField.layer.borderWidth = 1
        
        aboutMeTextField.textColor = .white
        stackAboutMeTextField.layer.backgroundColor = #colorLiteral(red: 0.2309213281, green: 0.2924915552, blue: 0.4204188585, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        self.editButtonDiPencet = false
        print(self.editButtonDiPencet)
        
        achievementCollectionView.reloadData()
        
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
                
                self.usernameLabelProfileUser.text = username
                
                
                if gender == "Male" {
                    self.genderLabel.text = ("♂️\(gender)")
                }else{
                    self.genderLabel.text = ("♀ \(gender)")
                }
                
                print(username, gender)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileUserViewController: UICollectionViewDelegate{
    
}

extension ProfileUserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementProfileCollectionViewCell
        
        if editButtonDiPencet == true {
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

extension ProfileUserViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profilePicture.image = image
        }else{
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
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
