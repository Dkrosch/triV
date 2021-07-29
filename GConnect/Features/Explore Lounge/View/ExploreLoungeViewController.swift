//
//  ExploreLoungeViewController.swift
//  GConnect
//
//  Created by Vincent on 27/07/21.
//

import UIKit

class ExploreLoungeViewController: UIViewController {
    
    @IBOutlet weak var createLoungeButton: UIButton!
    @IBOutlet weak var filterLoungeButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var loungeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loungeCollectionView.delegate = self
        loungeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(ExploreLoungeCell.self)", bundle: nil)
        loungeCollectionView.register(nib, forCellWithReuseIdentifier: "loungeCollectionViewCell" )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func createLoungeAction(_ sender: UIButton) {
        
    }
}

extension ExploreLoungeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
}

extension ExploreLoungeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loungeCollectionViewCell", for: indexPath) as! ExploreLoungeCell
        
        cell.exploreLoungeCellView.layer.borderColor = #colorLiteral(red: 1, green: 0.6593824029, blue: 0.5392141342, alpha: 1)
        cell.exploreLoungeCellView.layer.borderWidth = 1
        
        return cell
    }
}

extension ExploreLoungeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 174)
    }
}
