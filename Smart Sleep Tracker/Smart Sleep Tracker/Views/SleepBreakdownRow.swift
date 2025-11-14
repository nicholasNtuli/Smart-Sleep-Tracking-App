//
//  SleepBreakdownRow.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct SleepBreakdownRow: View {
    let icon: String
    let label: String
    let value: String
    let duration: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(color)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.primary.opacity(0.6))
                
                Text(value)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("Duration")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(.primary.opacity(0.5))
                
                Text(duration)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(color)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.primary.opacity(0.03))
        .cornerRadius(6)
    }
}

#Preview {
    SleepBreakdownRow(
        icon: "moon.zzz.fill",
        label: "Deep Sleep",
        value: "2h 15m",
        duration: "42%",
        color: .indigo
    )
    .padding()
}
