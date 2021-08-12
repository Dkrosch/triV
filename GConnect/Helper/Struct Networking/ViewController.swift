//
//  ViewController.swift
//  GConnect
//
//  Created by Dion Lamilga on 04/08/21.
//

import UIKit

class ViewController: UIViewController {

    var playerData = [PlayerData]()
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankScore: UILabel!
    @IBOutlet weak var legendLabel: UILabel!
    @IBOutlet weak var killLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var version = "5"
    var platform = "PC"
    var nickname: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        }
    

    @IBAction func btnTapped(_ sender: Any) {

        nickname = textField.text
        
        loadingView.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false){ (timer) in
            self.dismiss(animated: true)
            self.loadingView.isHidden = true
        }
        
        
        let loadingModal = UIStoryboard(name: "Loading", bundle: nil)
        let vc = loadingModal.instantiateViewController(identifier: "loadingScreen") as! LoadingViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
        ApiService.getDatas(url: "https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=\(nickname!)&auth=i6Xau6J5JvKzMy9J3LXI") { (response, error) in
            if response != nil {
                if let responseFromAPI = response {
                    self.nameLabel.text = responseFromAPI.global?.name
                    self.levelLabel.text = ("\(responseFromAPI.global!.level!)")
                    self.rankLabel.text = responseFromAPI.global?.rank?.rankName
                    self.rankScore.text = ("\(responseFromAPI.global!.rank!.rankScore!)")
                    self.legendLabel.text = responseFromAPI.legends?.selected?.LegendName
                    self.imageURL(urlKey: (responseFromAPI.legends?.selected?.ImgAssets?.icon)!)
                }
            }
        } failCompletion: { error in
            print(error)
        }

    }
    
    func imageURL(urlKey: String){
        if let url = URL(string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.profileImage.image = UIImage(data: data)
            } catch {
                print("error")
            }
        }
    }
}

