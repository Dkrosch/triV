//
//  PersonalChatListViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 23/08/21.
//

import UIKit
import Firebase

class PersonalChatListViewController: UIViewController {
    
    @IBOutlet weak var personalChatCollection: UICollectionView!
    
    var chatListVM = ChatListViewModel()
    var dataRoom = [PersonalChatRoom]()
    let myGroup = DispatchGroup()
    var dataUser = [TargetedUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personalChatCollection.delegate = self
        personalChatCollection.dataSource = self
        
        personalChatCollection.register(PersonalChatCollectionViewCell.nib(), forCellWithReuseIdentifier: PersonalChatCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataUser = []
        
        chatListVM.getDataChatRoom { data in
            
            for (index, _) in data.enumerated(){
                self.dataRoom.append(PersonalChatRoom(idPersonalChat: data[index].idPersonalChat, idUser: data[index].idUser))
            }
            
            self.chatListVM.getDataUser(data: data) { completion in
                for (index, _) in completion.enumerated(){
                    self.dataUser.append(TargetedUser(username: completion[index].username, role: completion[index].role, idPersonalChat: completion[index].idPersonalChat, idUser: completion[index].idUser))
                }
                
                DispatchQueue.main.async {
                    self.personalChatCollection.reloadData()
                }
            }
        }
    }
}

extension PersonalChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonalChatCollectionViewCell.identifier, for: indexPath) as! PersonalChatCollectionViewCell
        cell.background.layer.cornerRadius = 10
        cell.background.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        cell.background.layer.borderWidth = 1
        cell.labelUsername.text = dataUser[indexPath.row].username
        cell.labelRole.text = dataUser[indexPath.row].role
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gotoChat(idPersonalChat: dataUser[indexPath.row].idPersonalChat, nameUser: dataUser[indexPath.row].username, idTargetedUser: dataUser[indexPath.row].idUser)
    }
    
    func gotoChat(idPersonalChat: String, nameUser: String, idTargetedUser: String){
        let showProfile = UIStoryboard(name: "ChatPersonal", bundle: nil)
        let vc = showProfile.instantiateViewController(identifier: "ChatPersonal") as! ChatPersonalViewController
        vc.targetedUser = idTargetedUser
        vc.idPersonalChat = idPersonalChat
        vc.nameTargetedUser = nameUser
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 373, height: 85)
    }
}
