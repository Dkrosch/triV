//
//  Route.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 03/08/21.
//

import Foundation

enum Route {
    static let baseUrl = "https://api.mozambiquehe.re"
    
    case temp
    
    var description: String {
        switch self{
        case .temp: return "/bridge"
        }
    }
}
