//
//  TodayInteractor.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation

protocol TodayBusinessLogic {
    var presenter: TodayPresentationLogic? {get set}
    
    func fetchCityLocation(city: String)
    func fetchWether(cityModel: Coordinates.Coordinate)
    func seachCity(seach: String)
}
