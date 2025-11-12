//
//  SleepStageAnalyzer.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public final class SleepStageAnalyzer {
    private let accelerometerBuffer: [AccelerometerReading]
    private let breathingBuffer: [BreathingReading]
    
    public init(accelerometerBuffer: [AccelerometerReading],
                breathingBuffer: [BreathingReading]) {
        self.accelerometerBuffer = accelerometerBuffer
        self.breathingBuffer = breathingBuffer
    }
    
    public func analyzeSleepStages() -> [SleepStageData] {
        var stages: [SleepStageData] = []
        let windowSize = 300
        
        guard accelerometerBuffer.count > windowSize else {
            return [SleepStageData(stage: .light,
                                   startTime: Date(),
                                   duration: 300,
                                   confidence: 0.5)]
        }
        
        for i in stride(from: 0,
                        to: accelerometerBuffer.count - windowSize,
                        by: windowSize) {
            let window = Array(accelerometerBuffer[i..<min(i + windowSize, accelerometerBuffer.count)])
            let stage = classifyWindow(window)
            stages.append(stage)
        }
        
        return stages
    }
    
    private func classifyWindow(_ window: [AccelerometerReading]) -> SleepStageData {
        let averageMagnitude = window.map { $0.magnitude }.reduce(0, +) / Double(window.count)
        let variance = calculateVariance(window.map { $0.magnitude })
        let breathing = getBreathingForWindow(window)
        
        if averageMagnitude > 0.5 || variance > 0.3 {
            return SleepStageData(stage: .awake,
                                  startTime: window.first?.timestamp ?? Date(),
                                  duration: 300,
                                  confidence: 0.8)
        }
        
        if breathing.0 > 75 && averageMagnitude < 0.2 {
            return SleepStageData(stage: .deep,
                                  startTime: window.first?.timestamp ?? Date(),
                                  duration: 300,
                                  confidence: 0.75)
        }
        
        if variance > 0.1 && breathing.0 > 60 && breathing.0 < 75 && averageMagnitude < 0.3 {
            return SleepStageData(stage: .rem,
                                  startTime: window.first?.timestamp ?? Date(),
                                  duration: 300,
                                  confidence: 0.7)
        }
        
        return SleepStageData(stage: .light,
                              startTime: window.first?.timestamp ?? Date(),
                              duration: 300,
                              confidence: 0.65)
    }
    
    private func calculateVariance(_ values: [Double]) -> Double {
        guard !values.isEmpty else { return 0 }
        
        let mean = values.reduce(0, +) / Double(values.count)
        let squaredDifference = values.map { pow($0 - mean, 2) }
        
        return squaredDifference.reduce(0, +) / Double(values.count)
    }
    
    private func getBreathingForWindow(_ window: [AccelerometerReading]) -> (Double, Double) {
        let windowStart = window.first?.timestamp ?? Date()
        let windowEnd = window.last?.timestamp ?? Date()
        
        let breathingInWindow = breathingBuffer.filter { reading in
            reading.timestamp >= windowStart && reading.timestamp <= windowEnd
        }
        
        guard !breathingInWindow.isEmpty else { return (0, 0) }
        
        let averageRegularity = breathingInWindow.map { $0.regularity }.reduce(0, +) / Double(breathingInWindow.count)
        let averageFrequency = breathingInWindow.map(\.frequency).reduce(0, +) / Double(breathingInWindow.count)
        
        return (averageRegularity, averageFrequency)
    }
}
