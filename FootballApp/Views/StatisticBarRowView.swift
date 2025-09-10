//
//  StatisticBarRowView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 8/1/25.
//

import SwiftUI

struct StatisticBarRowView: View {
    let stat: MatchStatRow
    let homeColor: Color = .green
    let awayColor: Color = .blue
    
    var total: CGFloat { CGFloat(stat.homeValue + stat.awayValue) }
    var homeRatio: CGFloat {total > 0 ? CGFloat(stat.homeValue) / total : 0}
    var awayRatio: CGFloat {total > 0 ? CGFloat(stat.awayValue) / total : 0}
    
    var body: some View {
            HStack(spacing: 0) {
                Text(stat.homeDisplay)
                    .font(.caption)
                    .frame(width: 36, alignment: .leading)
                    .foregroundStyle(.black)
               
                Spacer()
                
                GeometryReader { geo in
                    HStack(spacing: 0) {
                        Capsule()
                            .fill(homeColor)
                            .frame(width: geo.size.width * homeRatio, height: 8)
                        Capsule()
                            .fill(awayColor)
                            .frame(width: geo.size.width * awayRatio, height: 8)
                    }
                    
                }
                .frame(width: 120, height: 8)
                .padding(.horizontal, 4)
                
                Spacer()
        
                Text(stat.awayDisplay)
                    .font(.caption)
                    .frame(width: 36, alignment: .leading)
                    .foregroundStyle(.black)
                
            }
            .frame(height: 18)
            .padding(.vertical, 2)
            .overlay(
                Text(stat.type)
                    .font(.caption2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .offset(y: -14),
                alignment: .top
            )
        
    }
    
}
