//
//  BottomLineTextField.swift
//  GConnect
//
//  Created by Michael Tanakoman on 27/07/21.
//

import UIKit

extension UITextField{
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 2)
        bottomLine.backgroundColor = #colorLiteral(red: 0.9950601459, green: 0.5900325775, blue: 0.4639726281, alpha: 1)
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
