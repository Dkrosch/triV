//
//  Struct.swift
//  GConnect
//
//  Created by Dion Lamilga on 29/07/21.
//

import Foundation

class Struct{
    
    struct detailLounge{
        var title: String
        var desc: String
        var idMemberLounge: [String] // isi member
        var idRequirementsLounge: [String] // isi requirement
        
        init(title: String, desc: String, idMemberLounge: [String], idRequirementsLounge: [String]) {
            self.title = title
            self.desc = desc
            self.idMemberLounge = idMemberLounge
            self.idRequirementsLounge = idRequirementsLounge
        }
    }
    
    struct user{
        var username: String
        var birthday: String
        var desc: String
        var imgProfile: String
        var achievement: [achievmentDetail]
        var statistic: [String]
        var gender: String
        
        init(username: String, birthday: String, desc: String, imgProfile: String, achievement: [achievmentDetail], statistic: [String], gender: String) {
            self.username = username
            self.birthday = birthday
            self.imgProfile = imgProfile
            self.desc = desc
            self.achievement = achievement
            self.statistic = statistic
            self.gender = gender
        }
    }
    
    struct achievmentDetail{
        var title: String
        var desc: String
        var image: String
    }
    
    struct statistic {
        //nyusul
    }
}
