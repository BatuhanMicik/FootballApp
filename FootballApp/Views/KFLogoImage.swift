//
//  KFLogoImage.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/13/25.
//  reusable view for badges

import SwiftUI
import Kingfisher

struct KFLogoImage: View {
    let url: String
    let size: CGFloat
    
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .padding(4)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .shadow(radius: 2)
            .contentShape(Circle())
    }
}
