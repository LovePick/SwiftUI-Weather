//
//  Constant.swift
//  Weather
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import Foundation
import SwiftUI


// MARK: - UI
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color("mediumPurple"), Color("iris")]), startPoint: .topLeading, endPoint: .bottomTrailing)
}


func convertTempKelvinToCelsius(kelvin: Double) -> Double {
    let celsiusTemp = kelvin - 273.15
    return celsiusTemp
}

func convertTempKelvinToFaranheit(kelvin: Double) -> Double  {
    let faranhei = ((9/5) * (kelvin - 273)) + 32
    return faranhei
}
