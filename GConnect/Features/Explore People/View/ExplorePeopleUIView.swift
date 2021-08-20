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
    
    func configureView(){
        searchBar.setupLeftImage(imageName: "magnifyingglass")
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search People", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(ExplorePeopleCollectionViewCell.nib(), forCellWithReuseIdentifier: ExplorePeopleCollectionViewCell.identifier)
        getData()
    }
}

extension ExplorePeopleUIView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePeopleCollectionViewCell.identifier, for: indexPath) as! ExplorePeopleCollectionViewCell
        
        if userProfile.count != 0 {
            DispatchQueue.main.async {
                cell.profilePicture.profileimageURL(urlKey: self.userProfile[indexPath.row].imageProfile)
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
