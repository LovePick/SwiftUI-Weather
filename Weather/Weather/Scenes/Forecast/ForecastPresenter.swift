//
//  ForecastPresenter.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import Foundation

protocol ForecastPresentationLogic {
    var view: ForecastViewDisplayLogic? {get set}
    func presentForecast(response: ForecastModel.FetchForecast.Response)
    func presentError(response: NetworkError)
}

class ForecastPresenter: ForecastPresentationLogic {
    var view: ForecastViewDisplayLogic?
    
    func presentForecast(response: ForecastModel.FetchForecast.Response) {
        
      
        let model = ForecastModel.ViewModel(forecast: response.forcast)
        view?.updateWithForecast(model: model)
    }
    
    func presentError(response: NetworkError) {
        view?.updateWithError(error: response)
    }
    
    
}
