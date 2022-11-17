//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import Foundation
import SwiftUI

@MainActor
class WeatherDataStore: ObservableObject {
    
    @Published var displaySearchCity: Coordinates.Coordinates = []
    @Published var currentWeather: CurrentWeather.CurrentWeather? = nil
    @Published var selectUnit: TodayModel.TempUnit = .c
    @Published var cityWeather: WeatherDetailmodel = WeatherDetailmodel(selectUnit: .c, tempKelvin: 0, windSpeed: 0, humidity: 0, icon: "10d", main: "Rain")
}
