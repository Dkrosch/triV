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
    
    var datas = [DetailLounge]()
    private var collectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        NetworkService.shared.myFirstRequest { (result) in
            switch result{
            case .success(let data):
                print("The decoded data is: \(data)")
            case .failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
            
        }
        
//        let service = NetworkService()
//        let request = service.createRequest(route: .temp, method: .get, parameters: ["version": "5", "platform": "PC", "player": "Pocounda", "auth": "JTQWkyqLXzJxFkVPu7dS"])
//        print("The URL is:  \(request?.url)")
        
        //"https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=Pocounda&auth=JTQWkyqLXzJxFkVPu7d"
        //https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=Pocounda&auth=JTQWkyqLXzJxFkVPu7dS
        
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(ExploreLoungeCell.self)", bundle: nil)
        loungeCollectionView.register(nib, forCellWithReuseIdentifier: "loungeCollectionViewCell" )
        
        collectionRef = Firestore.firestore().collection("LoungeDetail")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
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

                    let newData = DetailLounge(game: game,title: judul, desc: desc, idMemberLounge: [member1!, member2!, member3!, member4!, member5!, member6!, member7!, member8!, member9!, member10!], idRequirementsLounge: [role1!, role2!, role3!, role4!], documentId: documentId, creatAt: creatAt, gender: gender, rank: rank)

                    self.datas.append(newData)
                }
                self.loungeCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func createLoungeAction(_ sender: UIButton){
        performSegue(withIdentifier: "CreateLounge", sender: self)
    }

    @IBAction func setFilterTapped(_ sender: Any) {
        performSegue(withIdentifier: "SetFilter", sender: self)
    }
}

extension ExploreLoungeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeCollectionViewCell", for: indexPath) as! ExploreLoungeCell
        var num = 10
        
        cell.loungeNameLabel.text = datas[indexPath.row].title
        cell.descriptionLoungeLabel.text = datas[indexPath.row].desc
        cell.gamesNameLabel.text = "| \(datas[indexPath.row].game)"
        
        for member in datas[indexPath.row].idMemberLounge{
            print(member)
            
            if member == ""{
                num -= 1
            }
        }
    
        cell.totalMemberLabel.text = "\(num)/10"
        
        cell.exploreLoungeCellView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        cell.exploreLoungeCellView.layer.borderWidth = 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var idLounge = datas[indexPath.row].documentId
        performSegue(withIdentifier: "DetailLounge", sender: idLounge)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailLounge"){
            let loungeID = sender as? String
            let vc = segue.destination as? DetailLoungeViewController
            vc?.idLounge = loungeID!
        }
    }
}

extension ExploreLoungeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 174)
    }
}
