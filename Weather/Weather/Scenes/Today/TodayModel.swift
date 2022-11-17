//
//  TodayModel.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation

enum TodayModel {
    enum TempUnit: String {
        case c = "C"
        case f = "F"
        
    }
    
    enum FetchCity {
        struct Request {
            var city: String
            var limit: Int
            var apiKey: String
        }
        
        struct Response {
            var coordinates: Coordinates.Coordinates
        }
    }
    
    enum FetchWeather {
        struct Request {
            var lat: Double
            var lon: Double
        }
        
        struct Response {
            var weather: CurrentWeather.CurrentWeather
        }
    }
    
    struct ViewModel {
       
    }
}
