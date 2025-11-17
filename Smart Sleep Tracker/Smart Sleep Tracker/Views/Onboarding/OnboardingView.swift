//
//  OnboardingView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/17.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        TabView {
            OnboardingPage(
                title: "Proven\nTechniues",
                subtitle: "Effective solutions for restful nights for the whole family.",
                imageName: "OnboardingPart1"
            )
            
            OnboardingPage(
                title: "Personalised\nApproach",
                subtitle: "Customise sleep routine tailored to your body's specific needs.",
                imageName: "OnboardingPart2"
            )
            
            OnboardingPage(
                title: "Peaceful\nSleep",
                subtitle: "Science-based methods for healthy sleep habits",
                imageName: "OnboardingPart3"
            )
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea()
        .overlay(
            VStack {
                Spacer()
                
                Button(action: {
                    hasSeenOnboarding = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white.opacity(0.1))
                        .cornerRadius(16)
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 24)
            }
        )
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
