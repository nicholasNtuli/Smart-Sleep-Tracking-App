//
//  WeatherServicet.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/06.
//

import Foundation

public class WeatherService {
    static let shared = WeatherService()
    private init() {}
    
    private let baseURL = "https://api.weatherapi.com/v1"
    private var apiKey: String = "4a19992a9ee4468283272438252409"
    
    func setAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchCurrentWeather(latitude: Double, longitue: Double, completion: @escaping (Result<EnvironmentalData, Error>) -> Void) {
        guard !apiKey.isEmpty else {
            completion(.failure(SleepNetError.badURL))
            return
        }
        
        let endPoint = "\(baseURL)/current.json"
        var components = URLComponents(string: endPoint)
        
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(latitude),\(longitue)"),
            URLQueryItem(name: "aqi", value: "no")
        ]
        
        guard let url = components?.url else {
            completion(.failure(SleepNetError.badURL))
            return
        }
        
        NetworkService.shared.request(url) { (result: Result<WeatherAPIResponse, Error>) in
            switch result {
            case .success(let response):
                let environmentalData = EnvironmentalData(
                    temperature: response.current.temp_c,
                    humidity: Double(response.current.humidity),
                    windSpeed: response.current.wind_kph,
                    condition: response.current.condition.text,
                    timestamp: Date()
                )
                completion(.success(environmentalData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
