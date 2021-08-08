//
//  ChatListViewController.swift
//  GConnect
//
//  Created by vincent meidianto on 06/08/21.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var loungeCollection: UICollectionView!
    @IBOutlet weak var scChat: UISegmentedControl!
    @IBOutlet weak var listLoungeCollectionView: UICollectionView!
    
    var chatListVM = ChatListViewModel()
    var dataLounge = [DetailLounge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listLoungeCollectionView.delegate = self
        listLoungeCollectionView.dataSource = self
        
        loungeCollection.register(ListChatLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: ListChatLoungeCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataLounge = []
        
        chatListVM.getDataLounge(){ data in
            for (index, item) in data.enumerated(){
                self.dataLounge.append(DetailLounge(game: data[index].game, title: data[index].title, desc: data[index].desc, idMemberLounge: data[index].idMemberLounge, idRequirementsLounge: data[index].idRequirementsLounge, documentId: data[index].documentId, creatAt: data[index].creatAt, gender: data[index].gender, rank: data[index].rank))
            }
            
            DispatchQueue.main.async {
                self.listLoungeCollectionView.reloadData()
            }
        }
    }
}

extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gotoChat(idLounge: dataLounge[indexPath.row].documentId)
    }
    
    func gotoChat(idLounge: String){
        let showProfile = UIStoryboard(name: "ChatLounge", bundle: nil)
        let vc = showProfile.instantiateViewController(identifier: "ChatLounge") as! ChatLoungeViewController
        vc.idLounge = idLounge
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataLounge.count
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListChatLoungeCollectionViewCell.identifier, for: indexPath) as! ListChatLoungeCollectionViewCell
        cell.labelTitle.text = dataLounge[indexPath.row].title
        cell.labelDesc.text = dataLounge[indexPath.row].desc
        cell.viewBackground.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        cell.viewBackground.layer.borderWidth = 1
        
        var num = 10
        for member in dataLounge[indexPath.row].idMemberLounge{
            if member == ""{
                num -= 1
            }
        }
        cell.labelTotalMember.text = "\(num)/10"
        
        let sentinel = dataLounge[indexPath.row].idRequirementsLounge[0]
        let initiator = dataLounge[indexPath.row].idRequirementsLounge[1]
        let controller = dataLounge[indexPath.row].idRequirementsLounge[2]
        let duelist = dataLounge[indexPath.row].idRequirementsLounge[3]
        let rank = dataLounge[indexPath.row].rank
        let gender = dataLounge[indexPath.row].gender
        let initDataReq = DataRequirement(controller: controller, duelist: duelist, initiator: initiator, sentinel: sentinel, rank: rank, gender: gender)
        cell.setDataCollectionView(dataRequirement: initDataReq)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 120)
    }
}
