//
//  PastMatchesViewModel.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/13/25.
//

import Foundation

class PastMatchesViewModel: ObservableObject {
    @Published var selectedSeason: Int = 2024
    @Published var matches: [Fixture] = []
    @Published var matchesByRound: [String: [Fixture]] = [:]
    @Published var sortedRounds: [String] = []
    let seasons = [2024 ,2023, 2022, 2021, 2020]
    private let leagueId = 39
    
    

    func fetchPastMatches() {
        APIServices.shared.fetchFixtures(leagueId: leagueId, season: selectedSeason) { [weak self] fixtures in
            DispatchQueue.main.async {
                self?.matches = fixtures.filter { $0.fixture.status.short == "FT" }
                self?.groupFixturesByRound()
            }
            
        }
    }
    private func groupFixturesByRound() {
        var grouped: [String: [Fixture]] = [:]
        for fixture in matches {
            let round = fixture.league.round ?? "Unknown"
            grouped[round, default: []].append(fixture)
        }
        matchesByRound = grouped
        
        sortedRounds = grouped.keys.sorted { lhs, rhs in
            let lhsNumber = extractRoundNumber(from: lhs)
            let rhsNumber = extractRoundNumber(from: rhs)
            return lhsNumber < rhsNumber
            
        }
    }
    
    private func extractRoundNumber(from roundString: String) -> Int {
        let digits = roundString.compactMap { $0.wholeNumberValue }
        let numberString = digits.map(String.init).joined()
        return Int(numberString) ?? 0
    }
}


