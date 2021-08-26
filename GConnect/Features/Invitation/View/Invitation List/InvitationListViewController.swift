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
    var dataUser = [ProfileData]()
    var dataLounge = [DetailLounge]()
    var dataInvite = [GetDataInvitePeople]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invitationListCollectionView.delegate = self
        invitationListCollectionView.dataSource = self
        
        invitationListCollectionView.register(InvitationListCell.nib(), forCellWithReuseIdentifier: InvitationListCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        invitationListVM.getDataInvite { dataInvite in
            for (index, _) in dataInvite.enumerated(){
                self.dataInvite.append(GetDataInvitePeople(idLounge: dataInvite[index].idLounge, idInvitedUser: dataInvite[index].idInvitedUser, idMaster: dataInvite[index].idMaster, idInvite: dataInvite[index].idInvite))
            }
            
            DispatchQueue.main.async {
                self.invitationListCollectionView.reloadData()
            }
            
            self.invitationListVM.getDataLounge(dataInvite: dataInvite) { dataLounge in
                for (index, _) in dataLounge.enumerated(){
                    self.dataLounge.append(DetailLounge(game: dataLounge[index].game, title: dataLounge[index].title, desc: dataLounge[index].desc, idMemberLounge: dataLounge[index].idMemberLounge, idRequirementsLounge: dataLounge[index].idRequirementsLounge, documentId: dataLounge[index].documentId, creatAt: dataLounge[index].creatAt, gender: dataLounge[index].gender, rank: dataLounge[index].rank))
                }
                
                DispatchQueue.main.async {
                    self.invitationListCollectionView.reloadData()
                }
            }
            
            self.invitationListVM.getDataUser(dataInvite: dataInvite) { dataUser in
                
                for (index, _) in dataUser.enumerated(){
                    self.dataUser.append(ProfileData(username: dataUser[index].username, game: dataUser[index].game, gender: dataUser[index].gender, rank: dataUser[index].rank, role: dataUser[index].role, birthday: dataUser[index].birthday, imageProfile: dataUser[index].imageProfile, desc: dataUser[index].desc, gamerUname: dataUser[index].gamerUname))
                }
                
                DispatchQueue.main.async {
                    self.invitationListCollectionView.reloadData()
                }
            }
        }
    }
}

extension InvitationListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataLounge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InvitationListCell.identifier, for: indexPath) as! InvitationListCell
        cell.labelLoungeTitle.text = dataLounge[indexPath.row].title
        cell.loungeDescLabel.text = dataLounge[indexPath.row].desc
        cell.userNameLabel.text = dataUser[indexPath.row].username
        cell.userRoleLabel.text = dataUser[indexPath.row].role
        cell.configureCell(detailLounge: dataLounge[indexPath.row], idInvite: dataInvite[indexPath.row].idInvite)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 328, height: 253)
    }
}
