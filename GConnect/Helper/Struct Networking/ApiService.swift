//
//  ApiService.swift
//  GConnect
//
//  Created by Dion Lamilga on 04/08/21.
//

import Foundation
import UIKit

protocol ApiServiceProtocol {
    typealias PlayerDataCompletion = (PlayerData?, Error?) -> Void
}

class ApiService: UIViewController, ApiServiceProtocol {

    static func getDatas(url: String,
                  completion: @escaping PlayerDataCompletion,
                  failCompletion: @escaping (String) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in

            if let err = error {
                completion(nil, err)
                print("error")
            }

            guard let response = response as? HTTPURLResponse else{
                print("Empty")
                return
            }
            print ("respon Status: \(response.statusCode)")

            guard let data = data else{
                print("empty")
                return
            }

            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PlayerData.self, from: data)

                DispatchQueue.main.async {
                    completion(jsonData, nil)
                }
            } catch let error {
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
