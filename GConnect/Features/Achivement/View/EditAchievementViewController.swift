//
//  EditAchievementViewController.swift
//  GConnect
//
//  Created by Olga Husada on 29/07/21.
//

import UIKit
import Firebase
import FirebaseAuth

class EditAchievementViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var despLabel: UILabel!
    @IBOutlet weak var despTextField: UITextView!
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    var titleAchievement: String?
    var desc: String?
    var uid: String?
    var delegate: AddAchievementTapped?
    var status = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        titleTextField.text = (titleAchievement)
        despTextField.text = (desc)
        
        titleTextField.delegate = self
        despTextField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(updateDataAchievement))
        
    }
    
    @objc func updateDataAchievement(){
        
        let db = Firestore.firestore()
        
        let titleAchv = titleTextField.text
        let descAchv = despTextField.text
        
        db.collection("achievement").document(uid!).updateData(["Title": titleAchv ?? "" ,"Desc": descAchv ?? ""]){(error) in
            if error != nil{
                print("eror")
            } else{
                print("done")
            }
        }
        
    }
    
    func deleteDataAchievement(){
        let db = Firestore.firestore()
        
        db.collection("achievement").document(uid!).delete(){ (error) in
            
            if error != nil{
                print("eror")
            } else{
                print("done")
            }
            
        }
        status = true
        delegate?.deleteAchievement(isDelete: status)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 25
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 150
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Do your really want to delete this achievement? This process cannot be undone.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in
            self.deleteDataAchievement()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnEditImageTapped(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }else{
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureCell(dataAchievement: Achivement){
        desc = dataAchievement.desc
        titleAchievement = dataAchievement.title
        uid = dataAchievement.data
    }
}
