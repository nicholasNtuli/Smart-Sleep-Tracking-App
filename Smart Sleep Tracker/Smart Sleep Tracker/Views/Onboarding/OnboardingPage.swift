//
//  OnboardingPage.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/17.
//

import SwiftUI

struct OnboardingPage: View {
    @State private var currentPageIndex = 0
    private let totalPages = 3
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 80)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(height: 85, alignment: .topLeading)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    
                }
                .padding(.horizontal, 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    OnboardingPage(
        title: "Proven\nTechniques",
        subtitle: "Effective solutions for restful nights for the whole family.",
        imageName: "OnboardingPart6"
    )
}
