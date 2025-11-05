//
//  SleepStage.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/05.
//

import Foundation

public enum SleepStage: String, Codable {
    case awake = "Awake"
    case light = "Light Sleep"
    case deep = "Deep Sleep"
    case rem = "REM Sleep"
}
