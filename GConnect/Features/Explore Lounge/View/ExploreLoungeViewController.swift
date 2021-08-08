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
    var arrayRequirement: [String] = []
    var filter: FilterLounge?
    
    var datas = [DetailLounge]()
    private var collectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
        collectionRef = Firestore.firestore().collection("LoungeDetail")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        if let savedFilter = UserDefaults.standard.object(forKey: "filterLounge") as? Data{
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(FilterLounge.self, from: savedFilter){
                filter = loadedFilter
            }
        }
        
        datas = []
        
        var reference: Query?
        
        if filter?.statusFilter == true {
            print("true filternya")
            reference = Firestore.firestore().collection("LoungeDetail").whereField("idRequirementsLounge.Controller", isEqualTo: filter?.arrayRole[0]).whereField("idRequirementsLounge.Duelist", isEqualTo: filter?.arrayRole[1]).whereField("idRequirementsLounge.Initiator", isEqualTo: filter?.arrayRole[2]).whereField("idRequirementsLounge.Sentinel", isEqualTo: filter?.arrayRole[3]).whereField("Rank", isEqualTo: filter?.rank).whereField("Gender", isEqualTo: filter?.gender)
        } else if filter?.statusFilter == false{
            print("filternya false")
            reference = Firestore.firestore().collection("LoungeDetail")
        }
        
        reference!.getDocuments { snapshot, error in
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
                    print(self.datas[0].idRequirementsLounge)
                }
                self.loungeCollectionView.reloadData()
            }
        }
        loungeCollectionView.reloadData()
        print("data lounge: \(datas.count)")
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
        if datas.count != 0{
            return datas.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if datas.count != 0{
            let nib = UINib(nibName: "\(ExploreLoungeCell.self)", bundle: nil)
            loungeCollectionView.register(nib, forCellWithReuseIdentifier: "loungeCollectionViewCell" )
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeCollectionViewCell", for: indexPath) as! ExploreLoungeCell
            var num = 10
            
            cell.loungeNameLabel.text = datas[indexPath.row].title
            cell.descriptionLoungeLabel.text = datas[indexPath.row].desc
            cell.gamesNameLabel.text = "| \(datas[indexPath.row].game)"
            
            var sentinel = datas[indexPath.row].idRequirementsLounge[0]
            var initiator = datas[indexPath.row].idRequirementsLounge[1]
            var controller = datas[indexPath.row].idRequirementsLounge[2]
            var duelist = datas[indexPath.row].idRequirementsLounge[3]
            var rank = datas[indexPath.row].rank
            var gender = datas[indexPath.row].gender
            var initDataReq = DataRequirement(controller: controller, duelist: duelist, initiator: initiator, sentinel: sentinel, rank: rank, gender: gender)
            
            cell.setDataCollectionView(dataRequirement: initDataReq)
            
            for member in datas[indexPath.row].idMemberLounge{
                if member == ""{
                    num -= 1
                }
            }
        
            cell.totalMemberLabel.text = "\(num)/10"
            cell.exploreLoungeCellView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
            cell.exploreLoungeCellView.layer.borderWidth = 1
            
            return cell
        }else{
            loungeCollectionView.register(EmptyExploreLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyExploreLoungeCollectionViewCell.identifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyExploreLoungeCollectionViewCell.identifier, for: indexPath) as! EmptyExploreLoungeCollectionViewCell
            cell.viewBackground.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
            cell.viewBackground.layer.borderWidth = 1
            return cell
        }
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
