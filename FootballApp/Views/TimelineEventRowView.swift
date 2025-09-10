//
//  TimelineEventRowView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/28/25.
//

import SwiftUI
import Kingfisher

struct TimelineEventRowView: View {
    let event: MatchEvent
    let homeTeamId: Int
    
    var isHome: Bool {
        event.team.id == homeTeamId
    }
    
    var body: some View {
        HStack {
            if isHome {
                eventInfo
                Spacer()
                timeline
            } else {
                timeline
                Spacer()
                eventInfo
            }
        }
    }
    var eventInfo: some View {
        HStack {
            KFLogoImage(url: event.team.logo ?? "", size: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(event.player.name ?? "")
                    .font(.caption)
                    .bold()
                Text(event.readableDetails)
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
        }
    }
    var timeline: some View{
        VStack(spacing: 4) {
            Rectangle()
                .frame(width: 2, height: 20)
                .foregroundStyle(.gray)
            
            Text("\(event.time.elapsed ?? 0)")
                .font(.caption2)
                .foregroundStyle(.gray)
            
            Rectangle()
                .frame(width: 2, height: 20)
                .foregroundStyle(.gray)
        }
    }
}
