//
//  EventRowView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/27/25.
//

import SwiftUI
import Kingfisher


struct EventRowView: View {
    let event: MatchEvent
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack {
                Text("\(event.time.elapsed ?? 0)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                KFLogoImage(url: event.team.logo ?? "", size: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(event.type ?? "")
                        .font(.subheadline)
                        .bold()
                    Text(event.detail ?? "")
                        .font(.caption)
                    
                    if let player = event.player.name {
                        Text("\(player)")
                            .font(.caption)
                    }
                    
                    if let assist = event.assist?.name {
                        Text("Assist: \(assist)")
                            .font(.caption2)
                    }
                }
                Spacer()
            }
            .padding(.vertical, 6)
        }
    }
}
