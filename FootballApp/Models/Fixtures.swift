//
//  Fixtures.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/8/25.
//

//Football-data.org Data

import Foundation

    struct FixtureResponse: Decodable{
        let response: [Fixture]
        
    }

    struct Fixture: Decodable{
        let fixture: FixtureDetails
        let league: LeagueInfo
        let teams: FixtureTeams
        let goals: Goals
        let score: Score
    }

    struct FixtureDetails: Decodable {
        let id: Int
        let referee: String?
        let timezone: String?
        let date: String?
        let timestamp: Int?
        let periods: Periods
        let venue: Venue
        let status: StatusInfo
    }

    struct Periods: Decodable {
        let first: Int?
        let second: Int?
    }

    struct Venue: Decodable {
        let id: Int?
        let name: String?
        let city: String?
    }

    struct StatusInfo: Decodable {
        let long: String?
        let short: String?
        let elapsed: Int?
        let extra: Int?
    }

    struct LeagueInfo: Decodable {
        let id: Int
        let name: String?
        let country: String?
        let logo: String?
        let flag: String?
        let season: Int?
        let round: String?
        let standings: Bool?
    }

    struct FixtureTeams: Decodable {
        let home: TeamData
        let away: TeamData
    }

    struct TeamData: Decodable {
        let id: Int?
        let name: String?
        let logo: String?
        let winner: Bool?
    }

    struct Goals: Decodable {
        let home: Int?
        let away: Int?
    }

    struct Score: Decodable {
        let halftime: Goals?
        let fulltime: Goals?
        let extratime: Goals?
        let penalty: Goals?
    }
