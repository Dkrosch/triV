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
    let defaults = UserDefaults.standard
    
    var isiUD: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
        isiUD = defaults.bool(forKey: "isUserSignedIn")
        print("Ini UD \(isiUD)")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        let dataFilter = FilterLounge(statusFilter: false,game: "Apex Legends", role: [true, true, true, true], rank: "Bronze", gender: "All")
        let encoder = JSONEncoder()
        if let filter = try? encoder.encode(dataFilter){
            UserDefaults.standard.set(filter, forKey: "filterLounge")
        }
        
        let dataPeople = FilterPeople(statusFilter: false, game: "Apex Legends", role: [true, true, true, true], rank: "Bronze", gender: "All", recon: "Recon", support: "Support", offensive: "Offensive", defensive: "Defensive")
        let encoder2 = JSONEncoder()
        if let filter = try? encoder2.encode(dataPeople){
            UserDefaults.standard.set(filter, forKey: "filterPeople")
        }
        
        getDatas()
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
            cell.configureCell(detailLounge: datas[indexPath.row])
            return cell
        }else{
            loungeCollectionView.register(EmptyExploreLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyExploreLoungeCollectionViewCell.identifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyExploreLoungeCollectionViewCell.identifier, for: indexPath) as! EmptyExploreLoungeCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (defaults.object(forKey: "isUserSignedIn") != nil) == false{
            print("Ini False")
            let alert = UIAlertController(title: "Warning", message: "U must Login First", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancle", style: .destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if (defaults.object(forKey: "isUserSignedIn") != nil) == true {
            if datas.count != 0{
                print("Ini true")
                let idLounge = datas[indexPath.row].documentId
                performSegue(withIdentifier: "DetailLounge", sender: idLounge)
            }else{
                
            }
        }
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
