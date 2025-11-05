//
//  AccelerometerReading.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public struct AccelerometerReading {
    public let timestamp: Date
    public let magnitude: Double
    public let x: Double
    public let y: Double
    public let z: Double
    
    public init(timestamp: Date,
                magnitude: Double,
                x: Double,
                y: Double,
                z: Double) {
        self.timestamp = timestamp
        self.magnitude = magnitude
        self.x = x
        self.y = y
        self.z = z
    }
}
