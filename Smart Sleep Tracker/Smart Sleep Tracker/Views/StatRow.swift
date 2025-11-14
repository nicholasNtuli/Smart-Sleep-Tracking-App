//
//  StatRow.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import SwiftUI

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.secondary.opacity(0.9))
            
            Spacer()
            
            Text(value)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    List {
        StatRow(label: "Total Sleep", value: "7h 45m")
        StatRow(label: "Deep Sleep", value: "2h 10m")
        StatRow(label: "REM Sleep", value: "1h 30m")
        StatRow(label: "Awake Time", value: "25m")
        StatRow(label: "Sleep Score", value: "86")
    }
}
