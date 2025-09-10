//
//  Event.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/9/25.
//

import Foundation

struct MatchEventResponse: Decodable {
    let response: [MatchEvent]
}

struct MatchEvent: Decodable {
    let time: EventTime
    let team: EventTeam
    let player: EventPlayer
    let assist: Assist?
    let type: String?
    let detail: String?
    let comments: String?
    
}

struct EventTime: Decodable{
    let elapsed: Int?
    let extra: Int?
}

struct EventTeam: Decodable {
    let id: Int?
    let name: String?
    let logo: String?
}

struct EventPlayer: Decodable{
    let id: Int?
    let name: String?
}

struct Assist: Decodable {
    let id: Int?
    let name: String?
}

extension MatchEvent {
    var readableDetails: String {
        switch type?.lowercased() {
        case "card":
            switch detail {
            case "Yellow Card":
                return "🟨 Yellow Card"
            case "Red Card":
                return "🟥 Red Card"
            default:
                return "Card"
                
            }
            
        case "subst":
            return "Substitution"
        case "goal":
            return "Goal"
        default:
            return detail ?? ""
        }
    }
}
