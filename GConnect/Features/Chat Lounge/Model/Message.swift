//
//  Message.swift
//  GConnect
//
//  Created by Michael Tanakoman on 06/08/21.
//

import UIKit
import Firebase
import MessageKit

struct Message {
    var id: String
    var content: String
    var created: Timestamp
    var senderID: String
    var senderName: String
    var imageProfile: String
    var dictionary: [String: Any]{
        return [
            "id": id,
            "content": content,
            "created": created,
            "senderID": senderID,
            "senderName": senderName,
            "imageProfile": imageProfile]
    }
}

extension Message {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let content = dictionary["content"] as? String,
              let created = dictionary["created"] as? Timestamp,
              let senderID = dictionary["senderID"] as? String,
              let senderName = dictionary["senderName"] as? String,
              let imageProfile = dictionary["imageProfile"] as? String
        else {return nil}
        self.init(id: id, content: content, created: created, senderID: senderID, senderName: senderName, imageProfile: imageProfile)
    }
}

extension Message: MessageType {

    var sender: SenderType {
        return ChatUser(senderId: senderID, displayName: senderName, imageProfile: imageProfile)
    }

    var messageId: String {
        return id
    }

    var sentDate: Date {
        return created.dateValue()
    }

    var kind: MessageKind {
        return .text(content)
    }
}
