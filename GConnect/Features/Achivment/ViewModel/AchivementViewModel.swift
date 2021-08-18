//
//  AchivementModel.swift
//  GConnect
//
//  Created by Dion Lamilga on 15/08/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

extension AddAchievementViewController{
    func uploadImageToStorage(){

            let title = titleTextField.text
            let desc = despTextField.text
            guard let userID = Auth.auth().currentUser?.uid else { return }

            let storage = Storage.storage().reference()
            let db = Firestore.firestore()

            guard let imageDidSelect = self.imageSelected else {
                return
            }
            guard let imageData = imageDidSelect.jpegData(compressionQuality: 0.001) else {
                return
            }

            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            
        
            let photoRef = storage.child("AchievementImage").child("Achievement\(userID)").child(UUID().uuidString)

            photoRef.putData(imageData, metadata: metadata){ StorageMetadata, error in
                if error != nil{
                    print(error?.localizedDescription as Any)
                    return
                }

                photoRef.downloadURL { (url, error) in
                    if let metaImageURL = url?.absoluteString{
                        db.collection("achievement").document().setData(["Title": title ?? "", "Desc": desc ?? "", "Image": metaImageURL, "uid": userID]){ (error) in
                            if error != nil{
                                print("eror")
                            } else{
                                print("done")
                            }
                        }
                    }
                }
            }
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            imageSelected  = image
        }else{
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 150
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 25
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
