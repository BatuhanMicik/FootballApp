//
//  ContentView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            
            UpcomingMatchesView()
                .tabItem {
                    Label("Upcoming", systemImage: "clock.fill")
                }
            PastMatchesView()
                .tabItem {
                    Label("Results", systemImage: "clock.arrow.circlepath")
                }
        }
        
    }
    
}

#Preview {
    ContentView()
}
