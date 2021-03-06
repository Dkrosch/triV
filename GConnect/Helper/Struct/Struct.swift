//
//  Struct.swift
//  GConnect
//
//  Created by Dion Lamilga on 29/07/21.
//

import Foundation
import UIKit

class DetailLounge{
    var game: String
    var title: String
    var desc: String
    var idMemberLounge: [String] // isi member
    var idRequirementsLounge: [Bool]// isi requirement
    var documentId: String
    var creatAt: String
    var gender: String
    var rank: String
    
    init(game: String, title: String, desc: String, idMemberLounge: [String], idRequirementsLounge: [Bool], documentId: String, creatAt: String, gender: String, rank: String) {
        self.game = game
        self.title = title
        self.desc = desc
        self.idMemberLounge = idMemberLounge
        self.idRequirementsLounge = idRequirementsLounge
        self.documentId = documentId
        self.creatAt = creatAt
        self.gender = gender
        self.rank = rank
    }
}

class PersonalChatRoom{
    var idPersonalChat: String
    var idUser: [String]
    
    init(idPersonalChat: String, idUser: [String]) {
        self.idPersonalChat = idPersonalChat
        self.idUser = idUser
    }
}

class InvitePeople{
    var idLounge: String
    var idInvitedUser: String
    var idMaster: String
    
    init(idLounge: String, idInvitedUser: String, idMaster: String){
        self.idLounge = idLounge
        self.idInvitedUser = idInvitedUser
        self.idMaster = idMaster
    }
}

class MessageInvite{
    var title: String
    var msg: String
    var txtButton: String
    
    init(title: String, msg: String, txtButton: String){
        self.title = title
        self.msg = msg
        self.txtButton = txtButton
    }
}

class GetDataInvitePeople{
    var idLounge: String
    var idInvitedUser: String
    var idMaster: String
    var idInvite: String
    
    init(idLounge: String, idInvitedUser: String, idMaster: String, idInvite: String){
        self.idLounge = idLounge
        self.idInvitedUser = idInvitedUser
        self.idMaster = idMaster
        self.idInvite = idInvite
    }
}

class GetDataLoungeUser{
    var username: String
    var role: String
    var idMemberLounge: [String]
    var idRequirementsLounge: [Bool]
    var descLounge: String
    var idLounge: String
    var idInvite: String
    var titleLounge: String
    var rank: String
    
    init(username: String, role: String, idMemberLounge: [String], idRequirementsLounge: [Bool], descLounge: String, idLounge: String, idInvite: String, titleLounge: String, rank: String){
        self.username = username
        self.role = role
        self.idMemberLounge = idMemberLounge
        self.idRequirementsLounge = idRequirementsLounge
        self.descLounge = descLounge
        self.idLounge = idLounge
        self.idInvite = idInvite
        self.titleLounge = titleLounge
        self.rank = rank
    }
}

class TargetedUser {
    var username: String
    var role: String
    var idPersonalChat: String
    var idUser: String
    
    init(username: String, role: String, idPersonalChat: String, idUser: String){
        self.username = username
        self.role = role
        self.idPersonalChat = idPersonalChat
        self.idUser = idUser
    }
}

struct UserInfo{
    var uidUser: String
    var dataUser: [ProfileData]
}

class ProfileData{
    var username: String
    var game: String
    var gender: String
    var rank: String
    var role: String
    var birthday: String
    var imageProfile: String
    var desc: String
    var gamerUname: String
    
    init(username: String, game: String, gender: String, rank: String, role: String, birthday: String, imageProfile: String, desc: String, gamerUname: String) {
        self.username = username
        self.game = game
        self.gender = gender
        self.rank = rank
        self.role = role
        self.birthday = birthday
        self.imageProfile = imageProfile
        self.desc = desc
        self.gamerUname = gamerUname
    }
}

class ExplorePeople{
    var username: String
    var game: String
    var gender: String
    var rank: String
    var role: String
    var birthday: String
    var imageProfile: String
    var desc: String
    var imageRank: String
    var gamerUname: String
    var level: String
    var legend: String
    var idUser: String
    
    init(username: String, game: String, gender: String, rank: String, role: String, birthday: String, imageProfile: String, desc: String, imageRank: String, gamerUname: String, level: String, legend: String, idUser: String) {
        self.username = username
        self.game = game
        self.gender = gender
        self.rank = rank
        self.role = role
        self.birthday = birthday
        self.imageProfile = imageProfile
        self.desc = desc
        self.imageRank = imageRank
        self.gamerUname = gamerUname
        self.level = level
        self.legend = legend
        self.idUser = idUser
    }
}

class Achivement{
    var title: String
    var image: String
    var desc: String
    var uid: String
    var data: String
    
    init(title: String, image: String, desc: String, uid: String, data: String) {
        self.title = title
        self.image = image
        self.desc = desc
        self.uid = uid
        self.data = data
    }
}
