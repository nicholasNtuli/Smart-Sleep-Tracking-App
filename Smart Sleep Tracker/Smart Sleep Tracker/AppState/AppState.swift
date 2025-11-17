//
//  AppState.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/17.
//

import Foundation
internal import Combine

final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: "hasSeenOnboarding")
        }
    }
    
    init() {
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    }
}
