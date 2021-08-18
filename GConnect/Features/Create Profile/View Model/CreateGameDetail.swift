//
//  CreateGameDetail.swift
//  GConnect
//
//  Created by Dion Lamilga on 18/08/21.
//

import Foundation
import Firebase
import FirebaseAuth

extension CreateGameDetailViewController{
    
    func storeData(uname: String){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        if self.roleTextField.text == "Choose your role" {
            self.alert(msg: "Choose one role")
        }else if self.gamerUnameTextField.text == ""{
            self.alert(msg: "Insert your username")
        }else{
            ApiService.getDatas(url: "https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=\(uname)&auth=i6Xau6J5JvKzMy9J3LXI") { (response, error) in
                if response != nil {
                    if let responseFromAPI = response {
                        if responseFromAPI.global?.name == nil {
                            self.alert(msg: "Username is incorrect")
                        } else {
                            let db = Firestore.firestore()
                            let role = self.roleTextField.text
                            let rank = responseFromAPI.global!.rank!.rankName!
                            let gamerUname = self.gamerUnameTextField.text
                            let game = "Apex"

                            if self.roleTextField.text == "Choose your role"{
                                print("ga bisa bang")
                            }else{
                                db.collection("users").document(userID).updateData(["game": game, "role" : role ?? "", "rank" : rank, "gamerUname": gamerUname ?? ""]) {(error) in
                                    if error != nil{
                                        print("Gagal")
                                    } else {
                                        print("Sukses")
                                    }
                                }
                            }
                            
                            self.loadingView.isHidden = false
                            let dataFilter = FilterLounge(statusFilter: false,game: "Apex Legends", role: [true, true, true, true], rank: "Iron", gender: "All")
                            let encoder = JSONEncoder()
                            if let filter = try? encoder.encode(dataFilter){
                                UserDefaults.standard.set(filter, forKey: "filterLounge")
                            }
                            
                            self.loading()
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false){ (timer) in
                                self.dismiss(animated: true)
                                self.loadingView.isHidden = true
                                self.performSegue(withIdentifier: "ExploreLounge", sender: self)
                            }
                        }
                    }
                }
            } failCompletion: { error in
                print(error)
            }
        }
    }
    
    func alert(msg: String){
        let alert = UIAlertController(title: "Warning", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func loading(){
        let loadingModal = UIStoryboard(name: "Loading", bundle: nil)
        let vc = loadingModal.instantiateViewController(identifier: "loadingScreen") as! LoadingViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}