//
//  AddAchievementViewController.swift
//  GConnect
//
//  Created by Olga Husada on 29/07/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class AddAchievementViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var despLabel: UILabel!
    @IBOutlet weak var despTextField: UITextView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageSelected: UIImage? = nil
    var isAlreadyTapped = false
    var delegate: AddAchievementTapped?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Input the title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        titleTextField.delegate = self
        despTextField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    @objc func doneTapped(){
        isAlreadyTapped = true
        uploadImageToStorage()
        self.navigationController?.popViewController(animated: true)
        delegate?.addAchievement(isTapped: isAlreadyTapped)
    }
    
    @IBAction func btnEditImageTapped(_ sender: UIButton) {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
        }
    }
}
