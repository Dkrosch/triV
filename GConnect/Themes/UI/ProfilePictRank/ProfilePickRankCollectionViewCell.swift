//
//  ProfilePickRankCollectionViewCell.swift
//  GConnect
//
//  Created by Daffa Satria on 30/07/21.
//

import UIKit

@IBDesignable
class ProfilePickRankCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var RankThumbnail: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView(){
        guard let view = loadViewFromNib(nibName: "\(ProfilePickRankCollectionViewCell.self)") else { return }
        ProfilePic.layer.cornerRadius = ProfilePic.frame.height/2
        ProfilePic.layer.masksToBounds = false
        ProfilePic.clipsToBounds = true
        view.frame = self.bounds
        self.addSubview(view)
    }
}
