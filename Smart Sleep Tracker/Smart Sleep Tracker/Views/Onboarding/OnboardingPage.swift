//
//  OnboardingPage.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/17.
//

import SwiftUI

struct OnboardingPage: View {
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                Spacer()
                Spacer()
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    OnboardingPage(
        title: "Track Your Sleep",
        subtitle: "Understand your patterns and improve your rest with insights and gentle reminders.",
        imageName: "OnboardingPart2"
    )
}
