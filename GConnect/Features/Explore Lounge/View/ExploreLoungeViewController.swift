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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        let idLounge = datas[indexPath.row].documentId
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
