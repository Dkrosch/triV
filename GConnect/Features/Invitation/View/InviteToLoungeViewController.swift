//
//  InviteToLoungeViewController.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 23/08/21.
//

import UIKit

class InviteToLoungeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var loungeListCollectionView: UICollectionView!
    
    var invitationVM = InvitationViewModel()
    var dataOwnedLounge = [DetailLounge]()
    var selectedIndex: IndexPath?
    var idTargetedUser: String?
    var filteredDataLounge = [DetailLounge]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loungeListCollectionView.delegate = self
        loungeListCollectionView.dataSource = self
        
        //self.navigationController?.isNavigationBarHidden = false
        
        
        invitationVM.getDataOwnLounge { data in
            for (index, _) in data.enumerated(){
                self.dataOwnedLounge.append(DetailLounge(game: data[index].game, title: data[index].title, desc: data[index].desc, idMemberLounge: data[index].idMemberLounge, idRequirementsLounge: data[index].idRequirementsLounge, documentId: data[index].documentId, creatAt: data[index].creatAt, gender: data[index].gender, rank: data[index].rank))
                
                self.filteredDataLounge = self.invitationVM.validateLounge(dataLounge: self.dataOwnedLounge, idTargetedUser: self.idTargetedUser ?? "")
            }
            
            DispatchQueue.main.async {
                self.loungeListCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDataLounge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeListCell", for: indexPath)as! loungeListCollectionViewCell
        
        var req: [String] = []
        if filteredDataLounge[indexPath.row].idRequirementsLounge[0] == true { req.append("Defensive") }
        if filteredDataLounge[indexPath.row].idRequirementsLounge[1] == true { req.append("Recon") }
        if filteredDataLounge[indexPath.row].idRequirementsLounge[2] == true { req.append("Support") }
        if filteredDataLounge[indexPath.row].idRequirementsLounge[3] == true { req.append("Offensive") }
        
        cell.loungeTitleLabel.text = filteredDataLounge[indexPath.row].title
        cell.loungeRequirementLabel.text = ("\(filteredDataLounge[indexPath.row].rank) | \(req.joined(separator: " | "))")
        
        if indexPath == selectedIndex{
            cell.checkBtn.isSelected = true
        }else{
            cell.checkBtn.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell(index: indexPath)
    }
    
    func selectedCell (index: IndexPath){
        selectedIndex = index
        self.loungeListCollectionView.reloadData()
    }
    
    @objc func checkMarkBtnClicked ( sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
        loungeListCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 369, height: 52)
    }
    
}

