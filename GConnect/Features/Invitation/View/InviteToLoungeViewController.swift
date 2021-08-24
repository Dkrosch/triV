//
//  InviteToLoungeViewController.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 23/08/21.
//

import UIKit

class InviteToLoungeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var loungeListCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loungeListCollectionView.delegate = self
        loungeListCollectionView.dataSource = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeListCell", for: indexPath)as! loungeListCollectionViewCell
        cell.checkBtn.addTarget(self, action: #selector(checkMarkBtnClicked(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkMarkBtnClicked ( sender: UIButton) {
        print("button pressed")
        
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
        loungeListCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 338, height: 52)
    }
    
}

