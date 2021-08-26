//
//  InviteToLoungeViewController.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 23/08/21.
//

import UIKit

protocol InviteToLoungeDelegate {
    func showAlert(msg: String)
}

extension InviteToLoungeViewController: InviteToLoungeDelegate{
    func showAlert(msg: String) {
        alertInvited(msg: msg)
    }
}

class InviteToLoungeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var loungeListCollectionView: UICollectionView!
    
    var invitationVM = InvitationViewModel()
    var dataOwnedLounge = [DetailLounge]()
    var selectedIndex: IndexPath?
    var selectedIdLounge: String?
    var idTargetedUser: String?
    var nameTargetedUser: String?
    var filteredDataLounge = [DetailLounge]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        invitationVM.delegate = self
        
        loungeListCollectionView.delegate = self
        loungeListCollectionView.dataSource = self
        
        invitationVM.getDataOwnLounge { data in
            for (index, _) in data.enumerated(){
                self.dataOwnedLounge.append(DetailLounge(game: data[index].game, title: data[index].title, desc: data[index].desc, idMemberLounge: data[index].idMemberLounge, idRequirementsLounge: data[index].idRequirementsLounge, documentId: data[index].documentId, creatAt: data[index].creatAt, gender: data[index].gender, rank: data[index].rank))

                
                self.invitationVM.validateInvitedLounge(dataLounge: self.dataOwnedLounge, idTargetedUser: self.idTargetedUser ?? ""){ dataLoungeValidateInvited in
                    
                    self.filteredDataLounge = self.invitationVM.validateJoinedLounge(dataLounge: dataLoungeValidateInvited, idTargetedUser: self.idTargetedUser ?? "")
                    
                    DispatchQueue.main.async {
                        self.loungeListCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

        self.navigationItem.hidesBackButton = true
        let newButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(closeModal))
        self.navigationItem.leftBarButtonItem = newButton
    }
    
    @objc func donePressed(){
        if selectedIdLounge == nil{
            alert(msg: "Please select a lounge")
        }else{
            invitationVM.insertInvite(idLounge: selectedIdLounge ?? "", idUser: idTargetedUser ?? "", nameUser: nameTargetedUser ?? "")
        }
    }
    
    @objc func closeModal(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func alert(msg: String){
        let alert = UIAlertController(title: "Warning", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func alertInvited(msg: String){
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredDataLounge.count != 0{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
            return filteredDataLounge.count
        }else{
            self.navigationItem.rightBarButtonItem = nil
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if filteredDataLounge.count != 0{
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
        }else{
            loungeListCollectionView.register(EmptyLoungeInviteCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyLoungeInviteCollectionViewCell.identifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyLoungeInviteCollectionViewCell.identifier, for: indexPath)as! EmptyLoungeInviteCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell(index: indexPath, idLounge: filteredDataLounge[indexPath.row].documentId)
    }
    
    func selectedCell (index: IndexPath, idLounge: String){
        selectedIndex = index
        selectedIdLounge = idLounge
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

