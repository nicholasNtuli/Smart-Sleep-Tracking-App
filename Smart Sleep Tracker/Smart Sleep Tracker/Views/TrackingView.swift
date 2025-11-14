//
//  TrackingView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct TrackingView: View {
    @ObservedObject var viewModel: SleepViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.7, green: 0.8,  blue: 1.0))
                    .frame(width: 150, height: 150)
                    .shadow(color: Color.white.opacity(0.3), radius: 20)
                    
                Circle()
                    .fill(Color(red: 0.05, green: 0.05, blue: 0.05))
                    .frame(width: 60, height: 60)
                    .offset(x: 30, y: -30)
            }
            
            VStack(spacing: 12) {
                Text("Sleep Session Active")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.white.opacity(0.7))
                
                Text(viewModel.sessionDuration)
                    .font(.system(size: 20, weight: .light))
                    .foregroundStyle(.white)
                
                Text(viewModel.currentSessionInfo)
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.6))
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 12) {
                Button(action: { viewModel.recordAwakening() }) {
                    Label("Record Awakening", systemImage: "bell.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(red: 1.0, green: 0.3, blue: 0.3).opacity(0.8))
                        .cornerRadius(8)
                }
            }
        }
    }}

#Preview {
    TrackingView(viewModel: SleepViewModel())
}
