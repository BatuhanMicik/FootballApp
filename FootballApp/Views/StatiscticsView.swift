//
//  StatiscticsView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 8/1/25.
//

import SwiftUI

struct StatiscticsView: View {
    let rows: [MatchStatRow]
    var body: some View {
        VStack(spacing: 12) {
            ForEach(rows) { row in
                    StatisticBarRowView(stat: row)
            }
        }
        .padding()
        .background(Color.secondary)
        .cornerRadius(12)
    }
}
