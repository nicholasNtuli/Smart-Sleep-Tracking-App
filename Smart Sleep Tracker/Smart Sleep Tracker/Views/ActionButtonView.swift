//
//  ActionButtonView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct ActionButtonView: View {
    @ObservedObject var viewModel: SleepViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: { viewModel.toggleTracking() }) {
                Text(viewModel.isTracking ? "Stop Tracking" : "Start Traclking")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue, Color(red: 0.2, green: 0.3, blue: 0.6),
                                Color.blue, Color(red: 0.1, green: 0.2, blue: 0.4)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
            }
            
            if viewModel.lastAnalysis != nil {
                Button(action: { viewModel.resetData() }) {
                    Text("New Session")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    ActionButtonView(viewModel: SleepViewModel())
}
