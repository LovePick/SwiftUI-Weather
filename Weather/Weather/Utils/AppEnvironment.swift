//
//  AppEnvironment.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation

enum Enpoint {
    case cityCoordinates(String, Int, String)
    case currentWeather(Double, Double, String)
    case forecast(Double, Double, String)
    
    var path: String {
        switch self {
        case .cityCoordinates(let city, let limit, let key):
            return "/geo/1.0/direct?q=\(city)&limit=\(limit)&appid=\(key)"
        case .currentWeather(let lat, let lon, let key):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)"
        case .forecast(let lat, let lon, let key):
            return "/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(key)"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        
        // READ VALUE FROM ENIVONMENT VARIABLE
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        
        if env == "TEST" {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "http://api.openweathermap.org")!
        case .test:
            return URL(string: "http://api.openweathermap.org")!
        }
    }
    
    var key: String {
        switch self {
        case .dev:
            return "05270f7618b8d4b4e2454e1b0e0a22b2"
        case .test:
            return "05270f7618b8d4b4e2454e1b0e0a22b2"
        }
    }
}
