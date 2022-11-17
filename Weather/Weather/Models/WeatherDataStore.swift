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
}
