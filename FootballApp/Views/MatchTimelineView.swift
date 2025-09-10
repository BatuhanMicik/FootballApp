//
//  EventBubbleView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/28/25.
//

import SwiftUI
import Kingfisher

struct MatchTimelineView: View{
    let events: [MatchEvent]
    let homeTeamId: Int
    
    var body: some View{
        ScrollView {
            VStack(spacing: 20) {
                ForEach(events, id: \.player.name) { event in
                    TimelineEventRowView(event: event, homeTeamId: homeTeamId)
                    
                }
                
            }
            .padding()
            
        }
    }
}
