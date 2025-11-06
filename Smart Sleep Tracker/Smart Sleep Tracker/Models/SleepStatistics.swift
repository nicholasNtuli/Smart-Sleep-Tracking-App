//
//  SleepStatistics.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/06.
//

import Foundation

public struct SleepStatistics {
    public let averageQuality: Int
    public let averageDuration: TimeInterval
    public let totalSessions: Int
    public let bestNightQuality: Int
    public let worstNightQuality: Int
    public let averageDeepSleep: Double
    public let averageREMSleep: Double
    
    public init(sessions: [SleepSession]) {
        self.totalSessions = sessions.count
        
        let analyses = sessions.map { SleepAnalysis(session: $0)}
        
        if !analyses.isEmpty {
            let qualities = analyses.map { $0.quality }
            
            self.averageQuality = qualities.reduce(0, +) / qualities.count
            self.bestNightQuality = qualities.max() ?? 0
            self.worstNightQuality = qualities.min() ?? 0
            
            let deepSleep = analyses.map { $0.deepSleepPercentage }
            self.averageDeepSleep = deepSleep.reduce(0, +) / Double(deepSleep.count)
            
            let remSleep = analyses.map { $0.remSleepPercentage }
            self.averageREMSleep = remSleep.reduce(0, +) / Double(remSleep.count)
        } else {
            self.averageQuality = 0
            self.bestNightQuality = 0
            self.worstNightQuality = 0
            self.averageDeepSleep = 0
            self.averageREMSleep = 0
        }
        
        let durations = sessions.map { $0.duration }
        let totalDuration = durations.reduce(0, +)
        
        self.averageDuration = durations.isEmpty ? 0 : totalDuration / Double(durations.count)
    }
}
