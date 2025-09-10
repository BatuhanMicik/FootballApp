//
//  MatchDetailView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/24/25.
//

import SwiftUI
import Kingfisher

struct MatchDetailView: View {
    @StateObject private var viewModel: MatchDetailViewModel
    
    init(match: Fixture){
        _viewModel = StateObject(wrappedValue: MatchDetailViewModel(match: match))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    teamColumn(name: viewModel.homeTeamName, logoURL: viewModel.homeTeamLogoURL)
                    
                    VStack{
                        Text(viewModel.scoreText)
                            .font(.largeTitle.bold())
                        Text(viewModel.formattedDate)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    teamColumn(name: viewModel.awayTeamName, logoURL: viewModel.awayTeamLogoURL)
                }
                
                VStack(spacing: 8) {
                    Text("Venue: \(viewModel.venue)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("Status: \(viewModel.status)")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                    
                    Divider()
                    
                    if viewModel.events.isEmpty {
                        Text("No Events Available.")
                            .foregroundStyle(.gray)
                            .italic()
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Match Events")
                                .font(.headline)
                            MatchTimelineView(events: viewModel.events, homeTeamId: viewModel.homeTeamId ?? 0)
                            
                        }
                    }
                    
                    Divider()
                    
                    if viewModel.stats.isEmpty {
                        Text("No Events Available.")
                            .foregroundStyle(.gray)
                            .italic()
                    } else {
                        Text("Statistics")
                            .font(.headline)
                        StatiscticsView(rows: viewModel.stats)
                    }
                    
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Match Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func teamColumn(name: String, logoURL: String) -> some View {
        VStack{
            KFLogoImage(url: logoURL, size: 40)
            Text(name)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
    }
}
