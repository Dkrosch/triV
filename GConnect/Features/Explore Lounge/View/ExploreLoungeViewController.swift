//
//  ExploreLoungeViewController.swift
//  GConnect
//
//  Created by Vincent on 27/07/21.
//

import UIKit
import Firebase
import FirebaseAuth


class ExploreLoungeViewController: UIViewController {
    
    @IBOutlet weak var createLoungeButton: UIButton!
    @IBOutlet weak var filterLoungeButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var loungeCollectionView: UICollectionView!
    
    var jum = 0
    
    var datas = [Struct]()
    var dataLounge = DataLounge()
    private var collectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(ExploreLoungeCell.self)", bundle: nil)
        loungeCollectionView.register(nib, forCellWithReuseIdentifier: "loungeCollectionViewCell" )
        
        collectionRef = Firestore.firestore().collection("LoungeDetail")
        
       // DataLounge.showDatas()
        //print(datas)
//       print(dataLounge.showDatas())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        datas = []
        
        collectionRef.getDocuments { snapshot, error in
            if let err = error{
                print("error")
            } else {
                for document in (snapshot?.documents)!{
                    let data = document.data()
                    let creatAt = data["CreatAt"] as? String ?? ""
                    let desc = data["Desc"] as? String ?? ""
                    let game = data["Game"] as? String ?? ""
                    let judul = data["Title"] as? String ?? ""
                    let idMemberLounge = data["idMemberLounge"] as? [String: Any]
                    let member1 = idMemberLounge!["Member1"] as? String
                    let member2 = idMemberLounge!["Member2"] as? String
                    let member3 = idMemberLounge!["Member3"] as? String
                    let member4 = idMemberLounge!["Member4"] as? String
                    let member5 = idMemberLounge!["Member5"] as? String
                    let member6 = idMemberLounge!["Member6"] as? String
                    let member7 = idMemberLounge!["Member7"] as? String
                    let member8 = idMemberLounge!["Member8"] as? String
                    let member9 = idMemberLounge!["Member9"] as? String
                    let member10 = idMemberLounge!["Member10"] as? String
                    let idRequirementsLounge = data["idRequirementsLounge"] as? [String: Any]
                    let role1 = idRequirementsLounge!["Sentinel"] as? Bool
                    let role2 = idRequirementsLounge!["Initiator"] as? Bool
                    let role3 = idRequirementsLounge!["Controller"] as? Bool
                    let role4 = idRequirementsLounge!["Duelist"] as? Bool
                    let gender = data["Gender"] as? String ?? ""
                    let rank = data["Rank"] as? String ?? ""
                    let documentId = document.documentID
                    
                    let newData = Struct(game: game,title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt, gender: gender, rank: rank)
                    
                    self.datas.append(newData)
                }
                self.loungeCollectionView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func createLoungeAction(_ sender: UIButton) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        print("Data: \(userID)")
    }

}

extension ExploreLoungeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
}

extension ExploreLoungeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeCollectionViewCell", for: indexPath) as! ExploreLoungeCell
        
        cell.configureCell(detailLounge: datas[indexPath.row])
        
        return cell
    }
}

extension ExploreLoungeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 174)
    }
}
