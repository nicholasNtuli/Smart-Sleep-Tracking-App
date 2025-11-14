//
//  SettingsView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/14.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SleepViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
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
                
                List {
                    Section(header: SectionHeader("User Profile")) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.cyan)
                            
                            TextField("Enter your name", text: $viewModel.userName)
                                .textFieldStyle(.roundedBorder)
                        }
                        .listRowBackground(Color.primary.opacity(0.05))
                    }
                    
                    Section(
                        header: SectionHeader("Weather Configuration"),
                        footer: Text("Get your free API key from https://www.weatherapi.com")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.primary.opacity(0.5))
                    ) {
                        HStack {
                            Image(systemName: "key.fill")
                                .foregroundStyle(.yellow)
                            
                            SecureField("Enter API key", text: $viewModel.weatherAPIKey)
                                .textFieldStyle(.roundedBorder)
                                .textContentType(.password)
                        }
                        .listRowBackground(Color.primary.opacity(0.05))
                    }
                    
                    Section(header: SectionHeader("Sleep Statistics")) {
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        StatisticItem(
                            icon: <#T##String#>,
                            label: <#T##String#>,
                            value: <#T##String#>
                        )
                        .listRowBackground(Color.primary.opacity(0.05))
                    }
                    
                    if viewModel.isTracking {
                        Section(header: SectionHeader("")) {
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                                    .font(.system(size: 8))
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Recording in Progress")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(.primary)
                                    
                                    Text(viewModel.sessionDuration)
                                        .font(.system(size: 13, weight: .regular))
                                        .foregroundStyle(.primary.opacity(0.6))
                                }
                            }
                            .listRowBackground(Color.primary.opacity(0.05))
                        }
                    }
                    
                    Section(header: SectionHeader("About")) {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("App version")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundStyle(.primary.opacity(0.6))
                                
                                Spacer()
                                
                                Text("1.0.0")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(.primary)
                            }
                            
                            HStack {
                                Text("SDK Version")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundStyle(.primary.opacity(0.06))
                                
                                Spacer()
                                
                                Text("1.0.0")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(.primary)
                            }
                        }
                        .listRowBackground(Color.primary.opacity(0.05))
                        
                        Text("")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.primary.opacity(0.6))
                            .listRowBackground(Color.primary.opacity(0.05))
                    }
                }
                .navigationBarTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.cyan)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: SleepViewModel())
}
