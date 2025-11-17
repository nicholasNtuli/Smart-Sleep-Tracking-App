//
//  AnalsisView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct AnalsisView: View {
    @ObservedObject var viewModel: SleepViewModel
    let analysis: SleepAnalysis
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(Color.green.opacity(0.2), lineWidth: 12)
                    
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(analysis.quality) / 100)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.green,
                                    Color.cyan
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(
                                lineWidth: 12,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                    
                    VStack(spacing: 4) {
                        Text("Sleep Quality")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.primary.opacity(0.7))
                        
                        Text("\(analysis.quality)%")
                            .font(.system(size: 40, weight: .semibold))
                            .foregroundStyle(Color.primary)
                    }
                }
                .frame(height: 220)
                .padding(.vertical, 20)
                
                VStack(spacing: 12) {
                    SleepBreakdownRow(
                        icon: "moon.stars.fill",
                        label: "Deep Sleep",
                        value: viewModel.formatPercentage(analysis.deepSleepPercentage),
                        duration: viewModel.formatDuration(analysis.duration * analysis.deepSleepPercentage / 100),
                        color: Color.blue
                    )
                    
                    SleepBreakdownRow(
                        icon: "cloud.moon.fill",
                        label: "Light Sleep",
                        value: viewModel.formatPercentage(analysis.lightSleepPercentage),
                        duration: viewModel.formatDuration(analysis.duration * analysis.lightSleepPercentage / 100),
                        color: Color.cyan
                    )
                    
                    SleepBreakdownRow(
                        icon: "sparkles",
                        label: "REM Sleep",
                        value: viewModel.formatPercentage(analysis.remSleepPercentage),
                        duration: viewModel.formatDuration(analysis.duration * analysis.remSleepPercentage / 100),
                        color: Color.purple
                    )
                    
                    SleepBreakdownRow(
                        icon: "eye.fill",
                        label: "Awake",
                        value: viewModel.formatPercentage(analysis.awakePercentage),
                        duration: "-",
                        color: Color.red
                    )
                }
                .padding(.vertical, 16)
                
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "wind")
                            .font(.system(size: 14))
                            .foregroundStyle(.primary.opacity(0.7))
                        
                        Text("Breathing Analysis")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.primary)
                        
                        Spacer()
                    }
                    
                    StatRow(
                        label: "Average Rate",
                        value: "\(String(format: "%.1f", analysis.averageBreathingRate)) bpm"
                    )
                    
                    StatRow(
                        label: "Regularity",
                        value: viewModel.formatPercentage(analysis.breathingRegularity)
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
                
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.yellow)
                        
                        Text("Recommendation")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.primary.opacity(0.8))
                        
                        Spacer()
                    }
                    
                    Text(analysis.recommendation)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.primary.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
                
                StatRow(
                    label: "Total Duration",
                    value: viewModel.formatDuration(analysis.duration)
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    AnalsisView(
        viewModel: SleepViewModel(),
        analysis: SleepAnalysis(session: SleepSession())
    )
}
