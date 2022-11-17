//
//  TodayPresenter.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation

protocol TodayPresentationLogic {
    var view: TodayViewDisplayLogic? {get set}
    
    func presentCityList(response: TodayModel.FetchCity.Response)
    func presentCurrentWeather(response: TodayModel.FetchWeather.Response)
    func presentError(response: NetworkError)
}

class TodayPresenter {
    var view: TodayViewDisplayLogic?
}

// MARK: - TodayPresentationLogic
extension TodayPresenter: TodayPresentationLogic {
    
    func presentCityList(response: TodayModel.FetchCity.Response) {

        view?.updateSearchResult(cityList: response.coordinates)
    }
    
    func presentCurrentWeather(response: TodayModel.FetchWeather.Response) {
        
        view?.updateWeatherResult(weather: response.weather)
    }
    
    func presentError(response: NetworkError) {
        view?.updateError(error: response)
    }
}
