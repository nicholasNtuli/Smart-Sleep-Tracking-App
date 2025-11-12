//
//  SleepSession.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public struct SleepSession {
    // Constants
    public let id: String
    public let startTime: Date
    
    // Variables
    public var endTime: Date?
    public var duration: TimeInterval {
        let end = endTime ?? Date()
        return end.timeIntervalSince(startTime)
    }
    public var sleepQuality: Int?
    public var deepSleepDuration: TimeInterval = 0
    public var lightSleepDuration: TimeInterval = 0
    public var remSleepDuration: TimeInterval = 0
    public var awakenings: Int = 0
    public var heartRateAverage: Double?
    public var accelerometerData: [AccelerometerReading] = []
    public var audioBreathingData: [BreathingReading] = []
    public var sleepStages: [SleepStageData] = []
    public var environmentalData: EnvironmentalData?
    public var averageBreathingRate: Double = 0
    
    public init(startTime: Date = Date()) {
        self.id = UUID().uuidString
        self.startTime = startTime
    }
}
