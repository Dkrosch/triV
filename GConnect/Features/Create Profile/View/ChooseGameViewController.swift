//
//  ChooseGameViewController.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 29/07/21.
//

import UIKit

class ChooseGameViewController: UIViewController {

   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var username: String = ""
    var email: String = ""
    var dob: String = ""
    var password: String = ""
    var gender: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }

}

extension ChooseGameViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        cell.setup(with: games[indexPath.row])
        return cell
    }
}

extension ChooseGameViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}

extension ChooseGameViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(games[indexPath.row].title)
        goToChooseGame(username: username, email: email, dob: dob, password: password, gender: gender)
    }
    
    func goToChooseGame(username: String, email: String, dob: String, password: String, gender: String){
        let showProfile = UIStoryboard(name: "Choose game detail", bundle: nil)
        let vc = showProfile.instantiateViewController(identifier: "DetailViewController") as! CreateGameDetailViewController
        vc.username = username
        vc.email = email
        vc.dob = dob
        vc.password = password
        vc.gender = gender
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
