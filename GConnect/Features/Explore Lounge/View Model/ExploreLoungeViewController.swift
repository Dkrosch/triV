//
//  ExploreLoungeViewController.swift
//  GConnect
//
//  Created by Vincent on 27/07/21.
//

import UIKit
import Firebase


class ExploreLoungeViewController: UIViewController {
    
    @IBOutlet weak var createLoungeButton: UIButton!
    @IBOutlet weak var filterLoungeButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var loungeCollectionView: UICollectionView!
    
    var jum = 0
    
    var datas = [Struct]()
    private var collectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(ExploreLoungeCell.self)", bundle: nil)
        loungeCollectionView.register(nib, forCellWithReuseIdentifier: "loungeCollectionViewCell" )
        
        collectionRef = Firestore.firestore().collection("LoungeDetail")
        
        //print(datas[0].idMemberLounge[0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionRef.getDocuments { snapshot, error in
            if let err = error{
                print("error")
            } else {
                for document in (snapshot?.documents)!{
                    let data = document.data()
                    let creatAt = data["CreatAt"] as? String ?? ""
                    let desc = data["Desc"] as? String ?? ""
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
                    let gender = idRequirementsLounge!["Gender"] as? String
                    let rank = idRequirementsLounge!["Rank"] as? String
                    let role1 = idRequirementsLounge!["Role1"] as? String
                    let role2 = idRequirementsLounge!["Role2"] as? String
                    let role3 = idRequirementsLounge!["Role3"] as? String
                    let role4 = idRequirementsLounge!["Role4"] as? String
                    let documentId = document.documentID

                    let newData = Struct(title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [gender!, rank!, role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt)
                    
                //    let newData = Struct(title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [gender!, rank!, role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt)

                    self.datas.append(newData)
                }
                self.loungeCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func createLoungeAction(_ sender: UIButton) {
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
        var num = 10
        
        cell.loungeNameLabel.text = datas[indexPath.row].title
        cell.descriptionLoungeLabel.text = datas[indexPath.row].desc
        
        for member in datas[indexPath.row].idMemberLounge{
            print(member)
            
            if member == ""{
                num -= 1
            }
        }
    
        cell.totalMemberLabel.text = "\(num)"
        
        cell.exploreLoungeCellView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        cell.exploreLoungeCellView.layer.borderWidth = 1
        
        return cell
    }
}

extension ExploreLoungeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 174)
    }
}
