//
//  ProfilePicView.swift
//  GConnect
//
//  Created by Michael Tanakoman on 08/08/21.
//

import UIKit

@IBDesignable
class ProfilePicView: UIView {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var imageRank: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    func configureView(){
        guard let view = self.loadViewFromNib(nibName: "ProfilePic") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func gantiImageProfile(image: UIImage){
        imageProfile.image = image
    }
}
