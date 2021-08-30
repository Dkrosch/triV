//
//  PushNotificationSender.swift
//  GConnect
//
//  Created by Vincent on 28/08/21.
//

import UIKit

class PushNotificationSender {
    func sendPushNotification(to topic: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : "/topics/\(topic)",
                                           "collapse_key" : "type_a",
                                           "priority": 10,
                                           "data" : ["body" : body,
                                            "title": title]
                                            ]
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAq2N3lx0:APA91bHx2aF5NuZzWCQDQRLBig-p9ayg1v-WzFFfhoWqglfchIW2B04esd4cXrfCGHGvowpUOjQyLDSL4goYKkVTC5QLveFTcaP-ogLdNtrJp5pZHymg-5HyHoZAE6b10sT62yVwutLl", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
