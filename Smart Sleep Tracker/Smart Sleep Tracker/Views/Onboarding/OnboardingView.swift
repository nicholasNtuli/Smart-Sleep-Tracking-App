//
//  OnboardingView.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/17.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    
    @State private var viewState: ViewState = .welcome
    @State private var currentPageIndex = 0
    private let totalPages = 3
    
    enum ViewState {
        case welcome
        case onboarding
    }
    
    var body: some View {
        Group {
            if viewState == .welcome {
                WelcomeView(
                    title: "Your key to getting \nSleep better",
                    subtitle: "Peaceful nights start here!",
                    imageName: "OnboardingPart1",
                    onStart: {
                        withAnimation {
                            viewState = .onboarding
                        }
                    }
                )
            } else {
                ZStack {
                    TabView(selection: $currentPageIndex) {
                        OnboardingPage(
                            title: "Proven\nTechniques",
                            subtitle: "Effective solutions for restful nights for the whole family.",
                            imageName: "OnboardingPart2"
                        )
                        .tag(0)
                        
                        OnboardingPage(
                            title: "Personalised\nApproach",
                            subtitle: "Science-based methods for healthy sleep\nhabits and lasting rest",
                            imageName: "OnboardingPart6"
                        )
                        .tag(1)
                        
                        OnboardingPage(
                            title: "Achieve\nPeaceful Sleep",
                            subtitle: "Science-based methods for healthy sleep habits and lasting rest.",
                            imageName: "OnboardingPart4"
                        )
                        .tag(2)
                        .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        Spacer()
                        
                        HStack {
                            CustomPageControl(currentPage: $currentPageIndex, totalPages: totalPages)
                                .padding(.top, 16)
                                .padding(.bottom, 95)
                            
                            Spacer()
                        }
                        
                        Spacer()
                        Spacer()
                        
                        Group {
                            if currentPageIndex < totalPages - 1 {
                                HStack {
                                    Button(action: {
                                        hasSeenOnboarding = true
                                    }) {
                                        Text("skip")
                                            .font(.headline)
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.forward")
                                        .font(.headline.bold())
                                        .foregroundColor(.white.opacity(0.8))
                                        .onTapGesture {
                                            withAnimation {
                                                currentPageIndex += 1
                                            }
                                        }
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 60)
                            } else {
                                Button(action: {
                                    hasSeenOnboarding = true
                                }) {
                                    Text("Get Started")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(red: 0.05, green: 0.05, blue: 0.15))
                                        .padding(.vertical, 14)
                                        .frame(maxWidth: .infinity)
                                        .background(.white)
                                        .cornerRadius(16)
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 50)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
