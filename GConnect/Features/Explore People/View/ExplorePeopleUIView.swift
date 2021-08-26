//
//  ExplorePeopleUIView.swift
//  GConnect
//
//  Created by Michael Tanakoman on 19/08/21.
//

import UIKit

class ExplorePeopleUIView: UIView {
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var backgroundFilter: UIView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    var delegate: ExplorePeopleUIViewDelegate?
    var userProfile = [ExplorePeople]()
    var filter: FilterPeople?
    
    func configureView(){
        searchBar.setupLeftImage(imageName: "magnifyingglass")
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search People", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        searchBar.text = ""
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(ExplorePeopleCollectionViewCell.nib(), forCellWithReuseIdentifier: ExplorePeopleCollectionViewCell.identifier)
        getData { data in }
        
        searchBar.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc func textFieldChanged(){
        getData { data in
            self.getDataSearch(dataUser: data, searchText: self.searchBar.text ?? "") { search in
                self.userProfile.removeAll()
                for (index, _) in search.enumerated(){
                    self.userProfile.append(ExplorePeople(username: search[index].username, game: search[index].game, gender: search[index].gender, rank: search[index].rank, role: search[index].role, birthday: search[index].birthday, imageProfile: search[index].imageProfile, desc: search[index].desc, imageRank: search[index].imageRank, gamerUname: search[index].imageRank, level: search[index].level, legend: search[index].legend, idUser: search[index].idUser))
                }
                
                DispatchQueue.main.async {
                    self.userCollectionView.reloadData()
                }
            }
        }
    }
}

extension ExplorePeopleUIView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePeopleCollectionViewCell.identifier, for: indexPath) as! ExplorePeopleCollectionViewCell
        
        if userProfile.count != 0 {
            DispatchQueue.main.async {
//                cell.profilePicture.profileimageURL(urlKey: self.userProfile[indexPath.row].imageProfile)
            }
            cell.profilePicture.imageRank.image = UIImage(named: userProfile[indexPath.row].rank)
            cell.labelRoleUser.text = userProfile[indexPath.row].role
            cell.labelUsername.text = userProfile[indexPath.row].username
            cell.labelRank.text = userProfile[indexPath.row].rank
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userProfile.count != 0 {
            return userProfile.count
        }else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.goToHome(idUser: userProfile[indexPath.row].idUser)
    }
}
