//
//  MatchesRowView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/21/25.
//

import SwiftUI
import Kingfisher

struct MatchesRowView: View {
    let match: Fixture
    
    var body: some View {
        VStack{
            HStack {
                TeamColumnView(name: match.teams.home.name ?? "", logoURL: match.teams.home.logo ?? "")
                
                Spacer()
                
                if let homeGoals = match.goals.home,
                   let awayGoals = match.goals.away {
                    Text("\(homeGoals) - \(awayGoals)")
                        .font(.headline)
                } else {
                    Text("vs")
                }
                
                Spacer()
                
                TeamColumnView(name: match.teams.away.name ?? "", logoURL: match.teams.away.logo ?? "")
                
                
                
            }
                    
            Text(formattedDate(from: match.fixture.date ?? ""))
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
            
            
        }
        .padding(.vertical, 8)
    }
    private func formattedDate(from isoString: String) -> String{
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: isoString){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return isoString
    }
}
