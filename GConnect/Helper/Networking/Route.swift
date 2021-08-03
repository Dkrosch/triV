//
//  Route.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 03/08/21.
//

import Foundation

enum Route {
    static let baseUrl = "https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=Pocounda&auth=JTQWkyqLXzJxFkVPu7dS"
    
    //https://api.mozambiquehe.re/bridge?version=5&platform=PC&player=Pocounda&auth=JTQWkyqLXzJxFkVPu7dS
    
    case temp
    
    var description: String {
        switch self{
        case .temp: return "/bridge"
        }
    }
    
    var playerDesc: String{
        switch self{
        case .temp: return "version=5&platform=PC&player=Pocounda&auth=JTQWkyqLXzJxFkVPu7dS"
        }
    }
}
