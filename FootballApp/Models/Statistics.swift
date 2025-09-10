//
//  Statistics.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/11/25.
//

import Foundation

struct StatisticsResponse: Decodable{
    let response: [Stats]

}

struct Stats: Decodable {
    let statistics: [StatisticsArr]
    let team: Teams
}

enum StatValue: Decodable {
    case int(Int)
    case string(String)
    case none
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intVal = try? container.decode(Int.self) {
            self = .int(intVal)
        } else if let strVal = try? container.decode(String.self) {
            self = .string(strVal)
        } else {
            self = .none
        }
    }
}


struct StatisticsArr: Decodable {
    let type: String?
    let value: StatValue?
}



struct Teams: Decodable {
    let id: Int?
    let logo: String?
    let name: String?
}

extension StatisticsArr {
    var intValue: Int {
        switch value {
        case .int(let v): return v
        case .string(let s): return Int(s.replacingOccurrences(of: "%", with: "")) ?? 0
        default : return 0
        }
    }
    var displayString: String {
        if type?.lowercased().contains("Ball Possession") == true {
            return "\(intValue)%"
        } else if type?.lowercased().contains("Passes") == true {
            return "\(intValue)%"
        }
        return "\(intValue)"
    }
    
}

