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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loungeListCollectionView.delegate = self
        loungeListCollectionView.dataSource = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        
        invitationVM.getDataOwnLounge { data in
            for (index, _) in data.enumerated(){
                self.dataOwnedLounge.append(DetailLounge(game: data[index].game, title: data[index].title, desc: data[index].desc, idMemberLounge: data[index].idMemberLounge, idRequirementsLounge: data[index].idRequirementsLounge, documentId: data[index].documentId, creatAt: data[index].creatAt, gender: data[index].gender, rank: data[index].rank))
            }
            
            DispatchQueue.main.async {
                self.loungeListCollectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataOwnedLounge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeListCell", for: indexPath)as! loungeListCollectionViewCell
        
        var req: [String] = []
        if dataOwnedLounge[indexPath.row].idRequirementsLounge[0] == true { req.append("Defensive") }
        if dataOwnedLounge[indexPath.row].idRequirementsLounge[1] == true { req.append("Recon") }
        if dataOwnedLounge[indexPath.row].idRequirementsLounge[2] == true { req.append("Support") }
        if dataOwnedLounge[indexPath.row].idRequirementsLounge[3] == true { req.append("Offensive") }
        print(req)
        
        cell.checkBtn.addTarget(self, action: #selector(checkMarkBtnClicked(sender: )), for: .touchUpInside)
        cell.loungeTitleLabel.text = dataOwnedLounge[indexPath.row].title
        cell.loungeRequirementLabel.text = ("\(dataOwnedLounge[indexPath.row].rank) | \(req.joined(separator: " | "))")
        return cell
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

