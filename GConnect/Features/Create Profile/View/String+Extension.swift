//
//  String+Extension.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 03/08/21.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
