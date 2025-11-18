//
//  SleepSDK.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/12.
//

import Foundation
import CoreMotion
import HealthKit
import AVFoundation

public final class SleepSDK: NSObject {
    public static let shared = SleepSDK()
    
    private var currentSession: SleepSession?
    private var sessionHistory: [SleepSession] = []
    private let motionService = MotionSensorService()
    private let breathingAnalyser = BreathingAnalyzer()
    private var sessionDelegate: SleepSDKDelegate?
    private var audioEngine = AVAudioEngine()
    
    public var isTrackingActive: Bool {
        currentSession != nil
    }
    
    public override init() {
        super.init()
        requestHealthKitPermissions()
    }
    
    public func setDelegate(_ delegate: SleepSDKDelegate) {
        self.sessionDelegate = delegate
    }
    
    public func startTracking(withWeather: Bool = false, latitude: Double? = nil, longitude: Double? = nil) {
        guard currentSession == nil else {
            print("Session already active")
            return
        }
        
        currentSession = SleepSession()
        motionService.startTracking()
        startAudioBreathingAnalysis()
        
        if withWeather, let lat = latitude, let long = longitude {
            fetchWeatherData(latitude: lat, longitude: long)
        }
        
        sessionDelegate?.sleepSDKDidStartSession(self)
    }
    
    public func stopTracking() {
        guard var session = currentSession else {
            print("No active session")
            return
        }
        
        session.endTime = Date()
        session.accelerometerData = motionService.stopTracking()
        stopAudioBreathingAnalysis()
        
        let analyser = SleepStageAnalyzer(
            accelerometerBuffer: session.accelerometerData,
            breathingBuffer: session.audioBreathingData
        )
        
        session.sleepStages = analyser.analyzeSleepStages()
        
        for stage in session.sleepStages {
            switch stage.stage {
            case .deep:
                session.deepSleepDuration += stage.duration
            case .light:
                session.lightSleepDuration += stage.duration
            case .rem:
                session.remSleepDuration += stage.duration
            case .awake:
                break
            }
        }
        
        session.averageBreathingRate = session.audioBreathingData.isEmpty ? 0 : session.audioBreathingData.map { $0.frequency }.reduce(0, +) / Double(session.audioBreathingData.count)
        
        sessionHistory.append(session)
        
        let analysis = SleepAnalysis(session: session)
        sessionDelegate?.sleepSDK(self, didCompleteSession: session, withAnalysis: analysis)
        
        currentSession = nil
    }
    
    public func recordAwakening() {
        guard currentSession != nil else { return }
        currentSession?.awakenings += 1
    }
    
    public func getCurrentSession() -> SleepSession? {
        return currentSession
    }
    
    public func getSessionHistory() -> [SleepSession] {
        return sessionHistory
    }
    
    public func getLastAnalysis() -> SleepAnalysis? {
        guard let lastSession = sessionHistory.last else { return nil }
        return SleepAnalysis(session: lastSession)
    }
    
    public func getSleepStatistics() -> SleepStatistics {
        return SleepStatistics(sessions: sessionHistory)
    }
    
    private func startAudioBreathingAnalysis() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.record, mode: .default, options: [.duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session setup failed \(error)")
        }
    }
    
    private func stopAudioBreathingAnalysis() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: [.allowBluetoothA2DP, .mixWithOthers])
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
            print("Audio session stopped")
        } catch {
            print("Audio session deactivation failed \(error)")
        }
    }
    
    private func fetchWeatherData(latitude: Double, longitude: Double) {
        WeatherService.shared.fetchCurrentWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let environmentalData):
                self?.currentSession?.environmentalData = environmentalData
                self?.sessionDelegate?.sleepSDK(self ?? SleepSDK.shared, didUpdateEnvironmentalData: environmentalData)
                print("Weather data fetched \(environmentalData.temperature)°C")
            case .failure(let error):
                print("Weather fetch error \(error)")
            }
        }
    }
    
    private func requestHealthKitPermissions() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available on this device")
            return
        }
        
        let healthStore = HKHealthStore()
        
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("Sleep type is not available")
            return
        }
        
        let typesToRead: Set<HKObjectType> = [sleepType]
        let typesToWrite: Set<HKSampleType> = [sleepType as HKSampleType]
        
        healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead) { success, error in
            if success {
                print("HealthKit permissions granted")
            } else {
                print("HealthKit permission error: \(String(describing: error))")
            }
        }
    }
}

