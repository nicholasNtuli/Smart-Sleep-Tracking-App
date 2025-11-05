//
//  EnvironmentalData.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public struct EnvironmentalData {
    public let temperature: Double
    public let humidity: Double
    public let windSpeed: Double
    public let condition: String
    public let timestamp: Date
    
    public init(temperature: Double,
                humidity: Double,
                windSpeed: Double,
                condition: String,
                timestamp: Date) {
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.condition = condition
        self.timestamp = timestamp
    }
}
