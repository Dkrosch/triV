//
//  InvitationListViewController.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 20/08/21.
//

import UIKit
import Firebase

class InvitationListViewController: UIViewController{

    @IBOutlet weak var invitaionListCollectionView: UICollectionView!
    override func viewDidLoad() {
        
    var datas = [DetailLounge]()
        
        super.viewDidLoad()

//        invitaionListCollectionView.delegate = self
//        invitaionListCollectionView.dataSource = self
    }
    
    
    
//    extension InvitationListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            if datas.count != 0{
//                return datas.count
//            }else{
//                return 1
//            }
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            if datas.count != 0{
//                let nib = UINib(nibName: "\(ExploreLoungeCell.self)", bundle: nil)
//                invitaionListCollectionView.register(nib, forCellWithReuseIdentifier: "loungeCollectionViewCell" )
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeCollectionViewCell", for: indexPath) as! ExploreLoungeCell
//                cell.configureCell(detailLounge: datas[indexPath.row])
//                return cell
//            }else{
//                invitationListCollectionView.register(EmptyExploreLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyExploreLoungeCollectionViewCell.identifier)
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyExploreLoungeCollectionViewCell.identifier, for: indexPath) as! EmptyExploreLoungeCollectionViewCell
//                return cell
//            }
//        }
//
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if datas.count != 0{
//                let idLounge = datas[indexPath.row].documentId
//                performSegue(withIdentifier: "DetailLounge", sender: idLounge)
//            }else{
//
//            }
//        }
//
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if (segue.identifier == "DetailLounge"){
//                let loungeID = sender as? String
//                let vc = segue.destination as? DetailLoungeViewController
//                vc?.idLounge = loungeID!
//            }
//        }
//    }
    
   
   

}
