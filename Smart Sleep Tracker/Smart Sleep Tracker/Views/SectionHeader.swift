//
//  SectionHeader.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/14.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.cyan)
            .textCase(.uppercase)
    }
}

#Preview {
    SectionHeader("Sleep Quality")
}
