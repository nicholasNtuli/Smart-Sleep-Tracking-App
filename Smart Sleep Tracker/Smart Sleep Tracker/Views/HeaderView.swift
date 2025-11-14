//
//  HeaderView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: SleepViewModel
    let onSettings: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Goodnight, \(viewModel.userName)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white.opacity(0.7))
                
                Text(viewModel.currentTime)
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(.white)
                
                if let temperature = viewModel.currentTemperature {
                    HStack(spacing: 4) {
                        Image(systemName: "thermometer")
                            .font(.system(size: 10))
                        
                        Text("\(String(format: "%.1f", temperature))°C")
                            .font(.system(size: 12, weight: .regular))
                    }
                    .foregroundStyle(.white.opacity(0.6))
                }
            }
            
            Button(action: onSettings) {
                Image(systemName: "gear")
                    .font(.system(size: 10))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    HeaderView(viewModel: SleepViewModel(), onSettings: {})
}
