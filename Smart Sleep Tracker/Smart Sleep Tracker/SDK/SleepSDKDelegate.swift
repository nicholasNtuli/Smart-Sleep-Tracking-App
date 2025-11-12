//
//  SleepSDKDelegate.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/12.
//

import Foundation
import CoreMotion
import HealthKit
import AVFoundation

public protocol SleepSDKDelegate: AnyObject {
    func sleepSDKDidStartSession(_ sdk: SleepSDK)
    func sleepSDK(_ sdk: SleepSDK, didCompleteSession session: SleepSession, withAnalysis analysis: SleepAnalysis)
    func sleepSDK(_ sdk: SleepSDK, didUpdateEnvironmentalData data: EnvironmentalData)
}
