//
//  UpcomingViewModel.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/21/25.
//

import Foundation

class UpcomingViewModel: ObservableObject {
    @Published var matches: [Fixture] = []
    @Published var matchesByRound: [String: [Fixture]] = [:]
    @Published var sortedRounds: [String] = []
    private let leagueId = 39
    private let currentSeason = 2025
    
    
    func fetchUpcomingMatches() {
        APIServices.shared.fetchFixtures(leagueId: leagueId, season: currentSeason) { [weak self] fixture in
            DispatchQueue.main.async {
                self?.matches = fixture.filter {$0.fixture.status.short != "FT"}
                self?.groupFixturesByRound( )
            }
        }
        
    }
    private func groupFixturesByRound() {
        var grouped: [String: [Fixture]] = [:]
        
        for match in matches {
            let round = match.league.round ?? "Unknown"
                grouped[round, default: []].append(match)
            
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
