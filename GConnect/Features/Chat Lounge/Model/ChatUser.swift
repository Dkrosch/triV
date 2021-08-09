//
//  ChatUser.swift
//  GConnect
//
//  Created by Michael Tanakoman on 06/08/21.
//

import Foundation
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
    var imageProfile: String
}
