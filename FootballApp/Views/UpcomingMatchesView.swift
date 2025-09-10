//
//  UpcomingMatchesView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/9/25.
//

import SwiftUI
import Kingfisher

struct UpcomingMatchesView: View {
    @StateObject private var viewModel = UpcomingViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.sortedRounds, id: \.self){ round in
                    if let matches = viewModel.matchesByRound[round] {
                        Section(header: Text("\(round)")){
                            ForEach(matches, id: \.fixture.id){ fixture in
                                MatchesRowView(match: fixture)
                            }
                        }
                    }
                }
            }
            
        }
        .navigationTitle("Upcoming Matches")
        .onAppear {
            viewModel.fetchUpcomingMatches()
        }
    }
}
/*
struct UpcomingMatchesView: View {
    @State private var fixtures: [Match] = []
    var body: some View {
        NavigationStack {
            List(fixtures) { fixture in
                VStack(alignment: .leading) {
                    Text("\(fixture.homeTeam.name) vs \(fixture.awayTeam.name)")
                        .font(.headline)
                    
                    Text("Date: \(formatDate(fixture.utcDate))")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .navigationTitle("Upcoming Matches")
            .onAppear {
                APIServices.shared.fetchFixtures { fetched in
                    fixtures = fetched
                }
            }
        }
    }
 }*/
