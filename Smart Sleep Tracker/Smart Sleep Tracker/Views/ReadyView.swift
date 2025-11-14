//
//  ReadyView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct ReadyView: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(red: 1.0, green: 0.7, blue: 0.3))
                    .frame(width: 120, height: 120)
                
                Text("😴")
                    .font(.system(size: 60))
            }
            
            VStack(spacing: 8) {
                Text("Ready to Track Your Sleep")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.primary)
                
                Text("Place your phone on your nightstand and tap Start Tracking")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.primary.opacity(0.6))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ReadyView()
}
