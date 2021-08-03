//
//  APIResponse.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 03/08/21.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable{
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
