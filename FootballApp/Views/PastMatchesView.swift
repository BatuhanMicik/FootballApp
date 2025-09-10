//
//  PastMatchesView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/9/25.
//

import SwiftUI
import Kingfisher

struct PastMatchesView: View {
    @StateObject private var viewModel = PastMatchesViewModel()

    var body: some View {
        NavigationStack {
            VStack{
                
                Picker("Select Season", selection: $viewModel.selectedSeason){
                    ForEach(viewModel.seasons, id: \.self){ season in
                        Text(String(season))
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.sortedRounds, id: \.self) { round in
                        if let matches = viewModel.matchesByRound[round] {
                            Section(header: Text("\(round)").font(.headline)) {
                                ForEach(matches, id: \.fixture.id) { fixture in
                                    NavigationLink(destination: MatchDetailView(match: fixture)){
                                        MatchesRowView(match: fixture)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Past Matches")
                .onAppear {
                    viewModel.fetchPastMatches()
                }
                .onChange(of: viewModel.selectedSeason) { _, _ in
                    viewModel.fetchPastMatches()
                    
                }
            }
        }
    }
}
/*
struct PastMatchesView: View {
    @StateObject private var viewModel = PastMatchesViewModel()
    var body: some View {
        NavigationStack {
            VStack{
                Picker("Select Season", selection: $viewModel.selectedSeason){
                    ForEach(viewModel.seasons, id: \.self) { season in
                        Text(season)
                    }
                }
                .pickerStyle(.menu)
                .padding()
                
                List(viewModel.matches){ match in
                    HStack(spacing: 16){

                                    
                        KFLogoImage(teamName: match.strAwayTeam, viewModel: viewModel)
                            
                        
                        VStack(alignment: .leading){
                            Text(match.strEvent)
                                .font(.headline)
                            
                            if let home = match.intHomeScore, let away = match.intAwayScore {
                                Text("Score: \(home) - \(away)")
                            }
                            if let date = match.dateEvent {
                                Text("Date: \(date)")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                            }
                        }
                        Spacer()
                        KFLogoImage(teamName: match.strAwayTeam, viewModel: viewModel)
                        
                    }
                }
                .padding(.vertical, 4)
                
                .navigationTitle("Past Matches")
                .onAppear { viewModel.fetchMatches() }
                .onChange(of: viewModel.selectedSeason) { _, _ in viewModel.fetchMatches()
                }
                }
        }
    }
 }*/
