//
//  TeamColumnView.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/21/25.
//

import SwiftUI
import Kingfisher

struct TeamColumnView: View {
    let name: String
    let logoURL: String
   
    
    var body: some View {
  
        HStack(spacing: 4){
            KFLogoImage(url: logoURL, size: 40)
           
                Text(name)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    
                    .frame(width: 70)
                    .fixedSize()
                    .multilineTextAlignment(.center)
                
            
                
            
        }
    }
}
