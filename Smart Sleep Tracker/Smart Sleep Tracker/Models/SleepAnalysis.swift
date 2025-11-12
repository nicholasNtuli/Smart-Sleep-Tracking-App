//
//  SleepAnalysis.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public struct SleepAnalysis {
    public let quality: Int
    public let duration: TimeInterval
    public let deepSleepPercentage: Double
    public let lightSleepPercentage: Double
    public let remSleepPercentage: Double
    public let awakePercentage: Double
    public let averageBreathingRate: Double
    public let breathingRegularity: Double
    public let stageBreakdown: [SleepStageData]
    public let recommendation: String
    public let timestamp: Date
    
    public init(session: SleepSession) {
        self.timestamp = Date()
        self.duration = session.duration
        self.stageBreakdown = session.sleepStages
        
        let totalSleepTime = session.deepSleepDuration + session.lightSleepDuration + session.remSleepDuration + Double(session.awakenings) * 5
        
        self.deepSleepPercentage = totalSleepTime > 0 ? (session.deepSleepDuration / totalSleepTime) * 100 : 0
        self.lightSleepPercentage = totalSleepTime > 0 ? (session.lightSleepDuration / totalSleepTime) * 100 : 0
        self.remSleepPercentage = totalSleepTime > 0 ? (session.remSleepDuration / totalSleepTime) * 100 : 0
        self.awakePercentage = totalSleepTime > 0 ? (Double(session.awakenings) * 5 / totalSleepTime) * 100 : 0
        
        self.averageBreathingRate = session.averageBreathingRate
        
        let averageRegularity = session.audioBreathingData.isEmpty ? 0 : session.audioBreathingData.map { $0.regularity }.reduce(0, +) / Double(session.audioBreathingData.count)
        self.breathingRegularity = averageRegularity
        
        var qualityScore = 50
        
        let hours = session.duration / 3600
        if hours >= 7 && hours <= 9 {
            qualityScore += 30
        } else if hours >= 6.5 && hours < 7 {
            qualityScore += 15
        } else if hours > 9 && hours <= 10 {
            qualityScore += 15
        }
        
        qualityScore -= min(session.awakenings * 5, 20)
        
        if deepSleepPercentage >= 13 && deepSleepPercentage <= 23 {
            qualityScore += 15
        }
        
        if remSleepPercentage >= 20 && remSleepPercentage <= 25 {
            qualityScore += 10
        }

        if breathingRegularity >= 70 {
            qualityScore += 10
        }
        
        if let environment = session.environmentalData {
            if environment.temperature >= 16 && environment.temperature <= 19 {
                qualityScore += 10
            }
            
            if environment.humidity >= 30 && environment.humidity <= 60 {
                qualityScore += 10
            }
        }
        
        self.quality = max(0, min(100, qualityScore))
        
        if self.quality >= 85 {
            self.recommendation = "Excellent sleep! Keep your current routine."
        } else if self.quality >= 70 {
            self.recommendation = "Good sleep. Consider optimizing your bedroom environment."
        } else if self.quality >= 55 {
            self.recommendation = "Fair sleep. Try maintaining consistent sleep times."
        } else {
            self.recommendation = "Poor sleep quality. Review your sleep environment and schedule."
        }
    }
}
