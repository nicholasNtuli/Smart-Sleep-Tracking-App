//
//  BreathingReading.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public struct BreathingReading {
    public let timestamp: Date
    public let frequency: Double
    public let amplitude: Double
    public let regularity: Double
    
    public init (timestamp: Date,
                 frequency: Double,
                 amplitude: Double,
                 regularity: Double) {
        self.timestamp = timestamp
        self.frequency = frequency
        self.amplitude = amplitude
        self.regularity = regularity
    }
}
