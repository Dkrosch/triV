//
//  InvitationListViewController.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 20/08/21.
//

import UIKit
import Firebase

class InvitationListViewController: UIViewController{

    @IBOutlet weak var invitationListCollectionView: UICollectionView!
    
    var invitationListVM = InvitationListViewModel()
    var dataInvite = [GetDataInvitePeople]()
    var dataLoungeUser = [GetDataLoungeUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invitationListCollectionView.delegate = self
        invitationListCollectionView.dataSource = self
        
        invitationListCollectionView.register(InvitationListCell.nib(), forCellWithReuseIdentifier: InvitationListCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertInvited), name: Notification.Name(rawValue: "showAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCV), name: Notification.Name(rawValue: "refreshCollectionView"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        dataInvite.removeAll()
        dataLoungeUser.removeAll()
        
        invitationListVM.getDataInvite { dataInvite in
            for (index, _) in dataInvite.enumerated(){
                self.dataInvite.append(GetDataInvitePeople(idLounge: dataInvite[index].idLounge, idInvitedUser: dataInvite[index].idInvitedUser, idMaster: dataInvite[index].idMaster, idInvite: dataInvite[index].idInvite))
            }
            
            DispatchQueue.main.async {
                self.invitationListCollectionView.reloadData()
            }
            
            self.invitationListVM.getDataLoungeUser(dataInvite: self.dataInvite) { dataLoungeUser in
                
                for (index, _) in dataLoungeUser.enumerated(){
                    self.dataLoungeUser.append(GetDataLoungeUser(username: dataLoungeUser[index].username, role: dataLoungeUser[index].role, idMemberLounge: dataLoungeUser[index].idMemberLounge, idRequirementsLounge: dataLoungeUser[index].idRequirementsLounge, descLounge: dataLoungeUser[index].descLounge, idLounge: dataLoungeUser[index].idLounge, idInvite: dataLoungeUser[index].idInvite, titleLounge: dataLoungeUser[index].titleLounge, rank: dataLoungeUser[index].rank))
                }
                
                DispatchQueue.main.async {
                    self.invitationListCollectionView.reloadData()
                }
            }
        }
    }
    
    @objc func alertInvited(notification: NSNotification){
        let msg = notification.object as? MessageInvite
        let alert = UIAlertController(title: msg?.title, message: msg?.msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: msg?.txtButton, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func refreshCV(){
        viewWillAppear(true)
    }
}

extension InvitationListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataLoungeUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InvitationListCell.identifier, for: indexPath) as! InvitationListCell
        cell.labelLoungeTitle.text = dataLoungeUser[indexPath.row].titleLounge
        cell.loungeDescLabel.text = dataLoungeUser[indexPath.row].descLounge
        cell.userNameLabel.text = dataLoungeUser[indexPath.row].username
        cell.userRoleLabel.text = dataLoungeUser[indexPath.row].role
        cell.configureCell(dataLoungeUser: dataLoungeUser[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 328, height: 253)
    }
}
