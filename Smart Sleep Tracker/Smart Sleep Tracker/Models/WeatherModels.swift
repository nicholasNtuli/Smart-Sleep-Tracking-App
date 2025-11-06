//
//  WeatherModels.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/06.
//

import Foundation

public struct WeatherAPIResponse: Codable {
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let humidity: Int
    let wind_kph: Double
    let condition: WeatherCondition
}

struct WeatherCondition: Codable {
    let text: String
}
