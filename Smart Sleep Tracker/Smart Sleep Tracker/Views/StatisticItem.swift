//
//  StatisticItem.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/14.
//

import SwiftUI

struct StatisticItem: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.cyan)
                .frame(width: 24)
            
            VStack(alignment: .leading) {
                Text(label)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.primary.opacity(0.7))
                
                Text(value)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
        }
    }
}

#Preview("Statistic Item") {
    StatisticItem(
        icon: "moon.zzz.fill",
        label: "Sleep Duration",
        value: "7h 45m"
    )
    .padding()
}
