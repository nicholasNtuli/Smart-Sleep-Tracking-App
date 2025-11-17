//
//  ContentView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SleepViewModel()
    @State private var showSettings = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.15),
                    Color(red: 0.1, green: 0.05, blue: 0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HeaderView(viewModel: viewModel, onSettings: { showSettings = true })
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                
                Spacer()
                
                if viewModel.isTracking {
                    TrackingView(viewModel: viewModel)
                } else if let lastAnalysis = viewModel.lastAnalysis {
                    AnalsisView(viewModel: viewModel, analysis: lastAnalysis)
                } else {
                    ReadyView()
                }
                
                Spacer()
                
                ActionButtonView(viewModel: viewModel)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.startTimeUpdate()
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK") { viewModel.showError = false }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    ContentView()
}
