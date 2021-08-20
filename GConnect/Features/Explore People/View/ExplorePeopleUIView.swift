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
    
    func configureView(){
        searchBar.setupLeftImage(imageName: "magnifyingglass")
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search People", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.register(ExplorePeopleCollectionViewCell.nib(), forCellWithReuseIdentifier: ExplorePeopleCollectionViewCell.identifier)
    }
}

extension ExplorePeopleUIView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePeopleCollectionViewCell.identifier, for: indexPath) as! ExplorePeopleCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 149)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
