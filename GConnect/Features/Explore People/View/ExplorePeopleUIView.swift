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
    
    var userProfile = [ProfileData]()
    var dataPeople = DataPeople()
    
    func configureView(){
        searchBar.setupLeftImage(imageName: "magnifyingglass")
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search People", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(ExplorePeopleCollectionViewCell.nib(), forCellWithReuseIdentifier: ExplorePeopleCollectionViewCell.identifier)
        
        dataPeople.getData { fetchDataPeople in
            for (index, _) in fetchDataPeople.enumerated(){
                self.userProfile.append(ProfileData(username: fetchDataPeople[index].username, game: fetchDataPeople[index].game, gender: fetchDataPeople[index].gender, rank: fetchDataPeople[index].rank, role: fetchDataPeople[index].role, birthday: fetchDataPeople[index].birthday, imageProfile: fetchDataPeople[index].imageProfile, desc: fetchDataPeople[index].desc, imageRank: fetchDataPeople[index].imageRank, gamerUname: fetchDataPeople[index].gamerUname))
                
                
                print(self.userProfile[index].username)
                DispatchQueue.main.async {
                    self.userCollectionView.reloadData()
                }
            }
        }
      
    }
    
    func configureCellPeople(dataUser: [ProfileData]){
        self.userProfile = dataUser
    }
}

extension ExplorePeopleUIView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePeopleCollectionViewCell.identifier, for: indexPath) as! ExplorePeopleCollectionViewCell
        cell.profilePicture.profileimageURL(urlKey: userProfile[indexPath.row].imageProfile)
        cell.profilePicture.imageRank.image = UIImage(named: userProfile[indexPath.row].imageRank)
        cell.labelRoleUser.text = userProfile[indexPath.row].role
        cell.labelUsername.text = userProfile[indexPath.row].username
        cell.labelRank.text = userProfile[indexPath.row].rank
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userProfile.count != 0 {
            return userProfile.count
        }else{
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 149)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
