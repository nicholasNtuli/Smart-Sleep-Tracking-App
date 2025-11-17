//
//  SleepNetError.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/06.
//

import Foundation

enum SleepNetError: Error, LocalizedError {
    case badURL
    case requestFailed
    case decodingError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL"
        case .requestFailed:
            return "Request failed"
        case .decodingError:
            return "Failed to decode error"
        case .noData:
            return "No data found"
        }
    }
}
