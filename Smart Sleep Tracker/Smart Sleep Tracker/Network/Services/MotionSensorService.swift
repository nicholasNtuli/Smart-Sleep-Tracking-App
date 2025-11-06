//
//  MotionSensorService.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/06.
//

import Foundation
import CoreMotion
internal import Combine

final class MotionSensorService: NSObject, ObservableObject {
    @Published var accelermoterData: [AccelerometerReading] = []
    
    private let motionManager = CMMotionManager()
    private var motionUpdateTimer: Timer?
    
    func startTracking() {
        guard motionManager.isAccelerometerActive else {
            print("Accelerometer not available")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.startAccelerometerUpdates()
        
        motionUpdateTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            if let data = self?.motionManager.accelerometerData {
                let magnitude = sqrt(data.acceleration.x * data.acceleration.x +
                                     data.acceleration.y * data.acceleration.y +
                                     data.acceleration.z * data.acceleration.z)
                
                let reading = AccelerometerReading(
                    timestamp: Date(),
                    magnitude: magnitude,
                    x: data.acceleration.x,
                    y: data.acceleration.y,
                    z: data.acceleration.z
                )
                
                self?.accelermoterData.append(reading)
            }
        }
    }
    
    func stopTracking() -> [AccelerometerReading] {
        motionManager.stopAccelerometerUpdates()
        motionUpdateTimer?.invalidate()
        motionUpdateTimer = nil
        
        let data = accelermoterData
        accelermoterData = []
        
        return data
    }
}
