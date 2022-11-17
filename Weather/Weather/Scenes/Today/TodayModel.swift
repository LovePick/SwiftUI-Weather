//
//  TodayModel.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation
import SwiftUI

enum TodayModel {
    enum TempUnit: String {
        case c = "C"
        case f = "F"
    }
    
    enum FetchCity {
        struct Request { }
        
        struct Response {
            var coordinates: Coordinates.Coordinates
        }
    }
    
    enum FetchWeather {
        struct Request { }
        
        struct Response {
            var weather: CurrentWeather.CurrentWeather
        }
    }
    
    struct ViewModel {}
}

@MainActor
class WeatherDataStore: ObservableObject {
    
    @Published var displaySearchCity: Coordinates.Coordinates = []
    @Published var currentWeather: CurrentWeather.CurrentWeather? = nil
    @Published var selectUnit: TodayModel.TempUnit = .c
    @Published var cityWeather: WeatherDetailmodel = WeatherDetailmodel(selectUnit: .c, tempKelvin: 0, windSpeed: 0, humidity: 0, icon: "10d", main: "Rain")
}
