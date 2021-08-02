//
//  DetailLoungeViewController.swift
//  GConnect
//
//  Created by vincent meidianto on 29/07/21.
//

import UIKit

class DetailLoungeViewController: UIViewController {

    //@IBOutlet
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var Game: UITextField!
    @IBOutlet weak var Rank: UITextField!
    @IBOutlet weak var roles: UICollectionView!
    @IBOutlet weak var DescriptionTextbox: UITextView!
    @IBOutlet weak var JoinLoungeButton: UIButton!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderLabelDesc: UILabel!
    @IBOutlet weak var viewRole: UIView!
    @IBOutlet weak var RoleButton: UIButton!
    
    var idLounge = ""
    //var detailLoungeVM = DetailLoungeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ID Lounge: \(idLounge)")
        
        Rank.layer.cornerRadius = 8
        Rank.layer.borderWidth = 2
        Rank.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        gender.layer.cornerRadius = 8
        gender.layer.borderWidth = 2
        gender.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        Game.layer.cornerRadius = 8
        Game.layer.borderWidth = 2
        Game.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
        DescriptionTextbox.layer.cornerRadius = 8
        JoinLoungeButton.layer.cornerRadius = 8
        DeleteButton.isHidden = true
        DescriptionTextbox.layer.borderColor = UIColor.red.cgColor;
        
        let nibRoles = UINib(nibName: "\(RequirementExploreLoungeCollectionViewCell.self)", bundle: nil)
        roles.register(nibRoles, forCellWithReuseIdentifier: "cellContoh")
        
        CollectionView.register(DetailLoungeCollectionViewCell.nib(), forCellWithReuseIdentifier: DetailLoungeCollectionViewCell.identifier)
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        roles.delegate = self
        roles.dataSource = self
        
        self.view.addSubview(CollectionView)
        self.view.addSubview(roles)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Detail Lounge"
        gender.isHidden = true
        genderLabel.isHidden = true
        viewRole.isHidden = true
        //detailLoungeVM.getData(id: idLounge)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
    }
    @objc func editTapped(){
        DeleteButton.isHidden = false
        JoinLoungeButton.isHidden = true
        viewRole.isHidden = false
        roles.isHidden = true
        gender.isHidden = false
        genderLabel.isHidden = false
        genderLabelDesc.isHidden = true
        Rank.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        roles.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        roles.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        DescriptionTextbox.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
    }
    
    @objc func doneTapped(){
        Rank.layer.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2156862745, blue: 0.3254901961, alpha: 1)
        roles.layer.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2156862745, blue: 0.3254901961, alpha: 1)
        genderLabelDesc.isHidden = false
        DescriptionTextbox.layer.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2156862745, blue: 0.3254901961, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editTapped))
    }
}


extension DetailLoungeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.CollectionView{
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: DetailLoungeCollectionViewCell.identifier, for: indexPath) as! DetailLoungeCollectionViewCell
            
            cellA.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
            cellA.layer.borderWidth = 1
            cellA.layer.cornerRadius = 5
            return cellA
        }else{
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContoh", for: indexPath) as! RequirementExploreLoungeCollectionViewCell
            var requirement = RequirementExploreLoungeCollectionViewCell()
            cellB.layer.cornerRadius = 5
            cellB.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.5882352941, blue: 0.4666666667, alpha: 1)
            cellB.layer.borderWidth = 1
            return cellB
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.CollectionView{
            return CGSize(width: 92, height: 104)
        }else{
            return CGSize(width: 80, height: 32)
        }
    }
}
