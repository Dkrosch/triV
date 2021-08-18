//
//  SetRounded.swift
//  GConnect
//
//  Created by Michael Tanakoman on 18/08/21.
//

import Foundation
import UIKit

extension UIImageView {

    func setRounded(borderWidth: CGFloat = 0.0, borderColor: UIColor = UIColor.clear) {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
