//
//  AddAchievementViewController.swift
//  GConnect
//
//  Created by Olga Husada on 29/07/21.
//

import UIKit

class AddAchievementViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var despLabel: UILabel!
    @IBOutlet weak var despTextField: UITextView!
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Input the title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        titleTextField.delegate = self
        despTextField.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 25
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
        return updatedText.count <= 150
    }
    
    @IBAction func btnEditImageTapped(_ sender: UIButton) {
        
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

}