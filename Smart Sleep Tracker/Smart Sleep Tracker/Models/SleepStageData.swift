//
//  SleepStageData.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public struct SleepStageData {
    public let stage: SleepStage
    public let startTime: Date
    public let duration: TimeInterval
    public let confidence: Double
    
    public init(stage: SleepStage,
                startTime: Date,
                duration: TimeInterval,
                confidence: Double) {
        self.stage = stage
        self.startTime = startTime
        self.duration = duration
        self.confidence = confidence
    }
}
