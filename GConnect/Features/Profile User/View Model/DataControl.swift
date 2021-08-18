//
//  DataControl.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

extension ProfileUserViewController{
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
//                    self.achievementCollectionViewConstraintHeight.constant = self.achievementCollectionView.frame.size.height*CGFloat(self.dataachivement.count)
                    self.achievementCollectionView.frame.size.height = self.achievementCollectionView.frame.size.height*CGFloat(self.dataachivement.count)
//                    self.viewContentHeightConstraint.constant = 816 + self.achievementCollectionViewConstraintHeight.constant
                    self.viewContentHeightConstraint.constant = 816 + self.achievementCollectionView.frame.size.height
                    self.udahDiFetch = true
                }
                self.achievementCollectionView.reloadData()
            }
        })
    }
    
    func updateDataProfile(){
        let username = usernameTextField.text
        let about = aboutMeTextField.text
        
        let db = Firestore.firestore()
        db.collection("users").document(idUser).updateData(["About": about ?? "", "username": username ?? ""]){ (error) in
            
            if error != nil{
                print("eror")
            } else{
                print("done")
            }
        }
    }
    
    func fetchDataProfile(){
        let datas = Firestore.firestore()

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
    
    func imageURL(urlKey: String){
        if let url = URL(string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.legendImage.image = UIImage(data: data)
            } catch {
                print("error")
            }
        }
    }
    
    func profileimageURL(urlKey: String){
        if let url = URL(string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.profilePicture.image = UIImage(data: data)
            } catch {
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
                    print(error?.localizedDescription as Any)
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

    func logoutUserDefault(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do{
                let dataFilter = FilterLounge(statusFilter: false, game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
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
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func editOn(){
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
    }
    
    func finishEdit(){
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
