//
//  AppError.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 03/08/21.
//

import Foundation

enum AppError: LocalizedError{
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String?{
        switch self {
        case .errorDecoding:
        return "Response could not be decoded"
        case .unknownError:
        return "404 Not Found"
        case .invalidUrl:
        return "Need a valid URL"
        case .serverError(let error):
        return error
        }
        
    }
}
