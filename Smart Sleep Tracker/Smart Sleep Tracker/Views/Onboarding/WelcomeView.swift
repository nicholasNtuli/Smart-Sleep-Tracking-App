//
//  WelcomeView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/17.
//

import SwiftUI

struct WelcomeView: View {
    let title: String
    let subtitle: String
    let imageName: String
    let onStart: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 85, alignment: .topLeading)
                    
                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                    
                    Button(action: onStart) {
                        Text("Start")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.15))
                            .padding(.vertical, 14)
                            .frame(maxWidth: 150)
                            .background(.white)
                            .cornerRadius(16)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 70)
        .background(
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .ignoresSafeArea(.all)
    }
}

#Preview {
    WelcomeView(
        title: "make children\nsleep better",
        subtitle: "Peaceful nights start here!",
        imageName: "OnboardingPart1",
        onStart: {}
    )
}
