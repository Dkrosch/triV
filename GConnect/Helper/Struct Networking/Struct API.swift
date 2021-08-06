//
//  Struct API.swift
//  GConnect
//
//  Created by Dion Lamilga on 04/08/21.
//

import Foundation

struct PlayerData: Codable {
    var global: PlayerDataGlobalStatistic?
    var legends: PlayerDataLegends?
    var total: PlayerTotalKill?
}

struct PlayerDataGlobalStatistic: Codable {
    var name: String?
    var level: Int?
    var avatar: String?
    var rank: PlayerDataGlobalRankStatistic?
}

struct PlayerDataGlobalRankStatistic: Codable {
    var rankScore: Int?
    var rankName: String?
}

struct PlayerDataLegends: Codable{
    var selected: LegendName?
}

struct LegendName: Codable {
    var LegendName: String?
    var ImgAssets: ImageIcon?
}

struct ImageIcon: Codable{
    var icon: String?
}

struct PlayerTotalKill: Codable {
    var kills: KillTotal?
    var damage: DamageTotal?
    var headshots: HeadshotTotal?
}

struct KillTotal: Codable{
    var value: Int?
}

struct DamageTotal: Codable{
    var value: Int?
}
struct HeadshotTotal: Codable{
    var value: Int?
}
