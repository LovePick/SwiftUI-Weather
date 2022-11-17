//
//  ForecastModel.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import Foundation
import SwiftUI

enum ForecastModel {
    enum FetchForecast {
        struct Request{
            let lat:Double
            let lon:Double
        }
        
        struct Response{
            var forcast: [ForecastDay]
        }
    }
    
    struct ForecastItem: Codable, Identifiable {
        var id = UUID()
        var temp: Double
        var icon: String
        var main: String
        var winSpeed: Double
        var humidity: Int
        var dt_txt: String
        
    }
    
    struct ForecastDay: Codable, Identifiable {
        var id = UUID()
        var date: String
        var item:[ForecastItem]
    }
    struct ViewModel {
        var forecast: [ForecastDay]
    }
}

@MainActor
class ForecastDataStore: ObservableObject {
    @Published var forecast: ForecastModel.ViewModel = ForecastModel.ViewModel(forecast: [])
}
