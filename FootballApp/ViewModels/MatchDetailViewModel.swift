//
//  MatchDetailViewModel.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/23/25.
//

import Foundation

struct MatchStatRow: Identifiable {
    let id: String
    let type: String
    let homeValue: Int
    let awayValue: Int
    let homeDisplay: String
    let awayDisplay: String
}

class MatchDetailViewModel: ObservableObject{
    let match: Fixture
    @Published var events: [MatchEvent] = []
    @Published var stats: [MatchStatRow] = []
    
    init(match: Fixture){
        self.match = match
        fetchMatchEvents()
        fetchStatistics()
    }
    
    var homeTeamName: String{
        match.teams.home.name ?? ""
    }
    var homeTeamId: Int? {
        match.teams.home.id
    }
    
    var awayTeamName: String{
        match.teams.away.name ?? ""
    }
    
    var homeTeamLogoURL: String{
        match.teams.home.logo ?? ""
    }
    
    var awayTeamLogoURL: String{
        match.teams.away.logo ?? ""
    }
    
    var scoreText: String{
        let home = match.goals.home ?? 0
        let away = match.goals.away ?? 0
        
        return "\(home) - \(away)"
    }
    
    var venue: String{
        "\(match.fixture.venue.name ?? ""), \(match.fixture.venue.city ?? "")"
    }
    
    var status: String {
        match.fixture.status.long ?? ""
    }
    
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: match.fixture.date ?? ""){
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return match.fixture.date ?? ""
    }
    
    let statTitleMap: [String : String] = [
        "total shots" : "Shots",
        "ball possession" : "Possession",
        "goalkeeper saves" : "Saves",
        "passes accurate" : "Accurate Passes",
        "fouls" : "Fouls",
        "total passes" : "Passes"
        
    ]
    
    let shownStatTypes: Set<String> = [
        "total shots", "ball possession", "corner kicks", "yellow cards", "red cards", "goalkeeper saves", "passes accurate", "fouls", "total passes", "offsides"
    ]
    private func fetchMatchEvents(){
        APIServices.shared.fetchMatchEvents(fixtureId: match.fixture.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let events):
                    self?.events = events
                case .failure(let error):
                    print("Error fetching events: \(error)")
                }
            }
        }
    }
    private func fetchStatistics(){
        APIServices.shared.fetchStatistics(fixtureId: match.fixture.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let statsResponse):
                    self?.processStats(statsResponse)
                case .failure(let error):
                    print("Error fetching events: \(error)")
                }
            }
        }
    }
    private func processStats(_ statsResponse: [Stats]) {
        guard
            let homeId =  match.teams.home.id,
            let awayId = match.teams.away.id,
            let homeStats = statsResponse.first(where: { $0.team.id == homeId }),
            let awayStats = statsResponse.first(where: { $0.team.id == awayId })
        else {
            self.stats = []
            return
        }
        
        var rows: [MatchStatRow] = []
        for homeStat in homeStats.statistics {
            if let type = homeStat.type?.lowercased(),
               shownStatTypes.contains(type),
               let awayStat = awayStats.statistics.first(where: { $0.type?.lowercased() == type }) {
                
                let homeInt = homeStat.intValue
                let awayInt = awayStat.intValue
                let homeDisp = type.lowercased().contains("possession") ? "\(homeInt)%" : "\(homeInt)"
                let awayDisp = type.lowercased().contains("possession") ? "\(awayInt)%" : "\(awayInt)"
                
                let row = MatchStatRow(
                    id: type,
                    type: type,
                    homeValue: homeInt,
                    awayValue: awayInt,
                    homeDisplay: homeDisp,
                    awayDisplay: awayDisp
                )
                rows.append(row)
            }
            
        }
        self.stats = rows
    }
}
