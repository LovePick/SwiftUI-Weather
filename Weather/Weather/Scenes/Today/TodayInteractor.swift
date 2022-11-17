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
}

class TodayInteractor {
    
    // MARK: - PROPERTY
    private var config:Configuration
    var presenter: TodayPresentationLogic?
    
    // MARK: - INIT
    init(config: Configuration) {
        self.config = config
    }
    
    // MARK: - ACTION
    func handleError(error:NetworkError) {
        presenter?.presentError(response: error)
    }
    
    func fetchCitySuccess(cityList: Coordinates.Coordinates) {
        let response = TodayModel.FetchCity.Response(coordinates: cityList)
        presenter?.presentCityList(response: response)
    }
    
    func fetchWetherSucess(currentWeather: CurrentWeather.CurrentWeather) {
        let response = TodayModel.FetchWeather.Response(weather: currentWeather)
        presenter?.presentCurrentWeather(response: response)
    }
    
}

// MARK: - TodayBusinessLogic
extension TodayInteractor: TodayBusinessLogic{
    func fetchCityLocation(city: String) {
        
        guard let url = URL(string: Enpoint.cityCoordinates(city, 5, config.environment.key).path, relativeTo: config.environment.baseURL) else {
            handleError(error: NetworkError.badUrl)
            return
        }
        print(url.absoluteURL)
        
        getRequesWith(type: Coordinates.Coordinates.self, url: url) { [weak self] result in
            switch result {
            case .success(let cityList):
                self?.fetchCitySuccess(cityList: cityList)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchWether(cityModel: Coordinates.Coordinate) {
        
        guard let url = URL(string: Enpoint.currentWeather(cityModel.lat, cityModel.lon, config.environment.key).path, relativeTo: config.environment.baseURL) else {
            handleError(error: NetworkError.badUrl)
            return
        }
        
        getRequesWith(type: CurrentWeather.CurrentWeather.self, url: url) { [weak self] result in
            switch result {
            case .success(let currentWeather):
                self?.fetchWetherSucess(currentWeather: currentWeather)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
        
        
    }
    
}

