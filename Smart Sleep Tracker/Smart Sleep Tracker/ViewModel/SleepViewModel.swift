//
//  SleepViewModel.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/13.
//

import Foundation
import SwiftUI
import CoreLocation
internal import Combine

@MainActor
final class SleepViewModel: NSObject, ObservableObject, SleepSDKDelegate, CLLocationManagerDelegate {
    @Published var isTracking = false
    @Published var userName = "User"
    @Published var weatherAPIKey = ""
    @Published var currentTime = ""
    @Published var sessionDuration = ""
    @Published var currentSessionInfo = ""
    @Published var lastAnalysis: SleepAnalysis?
    @Published var statistics: SleepStatistics = .empty
    @Published var currentTemperature: Double?
    @Published var sleepStage: [SleepStageData] = []
    @Published var deepSleepPercent: Double = 0
    @Published var lightSleepPercent: Double = 0
    @Published var remSleepPercent: Double = 0
    @Published var breathingRate: Double = 0
    @Published var breathingRegularity: Double = 0
    @Published var sleepQuality: Int = 0
    @Published var showError = false
    @Published var errorMessage = ""
    
    private var sdk: SleepSDK
    private var timer: Timer?
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    
    var safeStatistics: SleepStatistics {
        statistics
    }
    
    override init() {
        self.statistics = SleepStatistics(sessions: [])
        self.sdk = SleepSDK.shared
        
        super.init()
        
        self.sdk.setDelegate(self)
        setUpLocationManager()
        updateTime()
    }
    
    private func setUpLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    @objc private func handleTimerTick() {
        updateTime()
    }
    
    func startTimeUpdate() {
        // Use target/selector to avoid capturing `self` in a @Sendable closure
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimerTick), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
        
        if isTracking {
            updateSessionDuration()
        }
    }
    
    private func updateSessionDuration() {
        guard let session = sdk.getCurrentSession() else { return }
        
        let duration = session.duration
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        
        sessionDuration = String(format: "%dh %dm", hours, minutes)
        
        currentSessionInfo = "Awakenings: \(session.awakenings) • Status Active"
    }
    
    func toggleTracking() {
        if isTracking {
            stopSleepTracking()
        } else {
            startSleepTracking()
        }
    }
    
    private func startSleepTracking() {
        let lat = currentLocation?.latitude ?? 0.0
        let long = currentLocation?.longitude ?? 0.0
        
        if !weatherAPIKey.isEmpty {
            WeatherService.shared.setAPIKey(weatherAPIKey)
        }
        
        sdk.startTracking(
            withWeather: !weatherAPIKey.isEmpty,
            latitude: lat,
            longitude: long
        )
        
        isTracking = true
    }
    
    private func stopSleepTracking() {
        sdk.stopTracking()
        isTracking = false
        timer?.invalidate()
    }
    
    func recordAwakening() {
        sdk.recordAwakening()
        
        if let session = sdk.getCurrentSession() {
            currentSessionInfo = "Awakenings: \(session.awakenings) • Status Active"
        }
    }
    
    func resetData() {
        lastAnalysis = nil
        statistics = SleepStatistics(sessions: [])
        sleepStage = []
        deepSleepPercent = 0.0
        lightSleepPercent = 0.0
        remSleepPercent = 0.0
        breathingRate = 0.0
        breathingRegularity = 0.0
        sleepQuality = 0
    }
    
    func formatDuration(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        
        return String(format: "%dh %dm", hours, minutes)
    }
    
    
    func formatPercentage(_ value: Double) -> String {
        String(format: "%.0f%%", value)
    }
    
    func sleepSDKDidStartSession(_ sdk: SleepSDK) {
        print("Sleep tracking started")
        currentSessionInfo = "Awakenings: 0 • Status Active"
    }
    
    func sleepSDK(_ sdk: SleepSDK, didCompleteSession session: SleepSession, withAnalysis analysis: SleepAnalysis) {
        print("Sleep session completed")
        print("Quality: \(analysis.quality)%")
        print("Deep Sleep: \(String(format: "%.1f", analysis.deepSleepPercentage))%")
        print("Light Sleep: \(String(format: "%.1f", analysis.lightSleepPercentage))%")
        print("Rem Sleep: \(String(format: "%.1f", analysis.remSleepPercentage))%")
        print("Breathing Rate: \(String(format: "%.1f", analysis.averageBreathingRate)) bpm")
        
        self.lastAnalysis = analysis
        self.statistics = sdk.getSleepStatistics()
        self.sleepStage = analysis.stageBreakdown
        self.deepSleepPercent = analysis.deepSleepPercentage
        self.lightSleepPercent = analysis.lightSleepPercentage
        self.remSleepPercent = analysis.remSleepPercentage
        self.breathingRate = analysis.averageBreathingRate
        self.breathingRegularity = analysis.breathingRegularity
        self.sleepQuality = analysis.quality
    }
    
    func sleepSDK(_ sdk: SleepSDK, didUpdateEnvironmentalData data: EnvironmentalData) {
        self.currentTemperature = data.temperature
        print("Weather: \(data.temperature)°C, \(data.humidity)% humidity")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentLocation = location.coordinate
        print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location error: \(error)")
        showError = true
        errorMessage = "Failed to get location"
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            print("Location permission granted")
        case .denied, .restricted:
            print("Location permission denied")
            showError = true
            errorMessage = "Location permission denied"
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    deinit {
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
}

