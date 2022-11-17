//
//  ForecastInteractor.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import Foundation

protocol ForecastBusinessLogic {
    
    var presenter: ForecastPresentationLogic? {get set}
    func fetchWeatherforcast(request: ForecastModel.FetchForecast.Request)
}

class ForecastInteractor: ForecastBusinessLogic {
    
    // MARK: - PROPERTY
    private var config:Configuration
    var presenter: ForecastPresentationLogic?
    
    // MARK: - INIT
    init(config: Configuration) {
        self.config = config
    }
    // MARK: - ACTION
    func handleError(error:NetworkError) {
        print(error)
     
    }
    
    func fetchForecastSuccess(forcast: Forecast.Forecast) {
        
        var arItem = [ForecastModel.ForecastDay]()
        
        if let list = forcast.list {

            var newDay = [ForecastModel.ForecastItem]()
            var lastKey = ""
            
            for item in list {
                var temp = 0.0
                var humidity = 0
                
                var main = ""
                var icon = ""
                
                var winSpeed = 0.0
                
                let dt_txt = item.dtTxt ?? ""
                
                if let m = item.main {
                    temp = m.temp ?? 0
                    humidity = m.humidity ?? 0
                }
                
                if let w = item.weather {
                    if let f = w.first {
                        main = f.main ?? ""
                        icon = f.icon ?? ""
                    }
                }
                
                if let w = item.wind {
                    winSpeed = w.speed ?? 0
                }
                
                let key = displayDateWith(strDate: dt_txt)
                
                let item = ForecastModel.ForecastItem(temp: temp, icon: icon, main: main, winSpeed: winSpeed, humidity: humidity, dt_txt: dt_txt)
                
                if(lastKey != key){
                  
                    if(newDay.count > 0) {
                        let newItem = ForecastModel.ForecastDay(date: lastKey, item: newDay)
                        arItem.append(newItem)
                    }
                    
                    newDay = [ForecastModel.ForecastItem]()
                    newDay.append(item)
                    lastKey = key
                }else{
                    newDay.append(item)
                }
                
               
            }

            if(newDay.count > 0) {
                let newItem = ForecastModel.ForecastDay(date: lastKey, item: newDay)
                arItem.append(newItem)
            }
        }
        
        presenter?.presentForecast(response: ForecastModel.FetchForecast.Response(forcast: arItem))
        
    }
    
    
    func displayDateWith(strDate:String) -> String {
        let str = strDate.components(separatedBy: " ")
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        guard let date = dateformat.date(from: str[0]) else { return "" }
        
        let disPlayDate = DateFormatter()
        disPlayDate.dateStyle = .long
        let result = disPlayDate.string(from: date)
        return result
    }
}

extension ForecastInteractor {
    func fetchWeatherforcast(request: ForecastModel.FetchForecast.Request) {
        
        guard let url = URL(string: Enpoint.forecast(request.lat, request.lon, config.environment.key).path, relativeTo: config.environment.baseURL) else {
            handleError(error: NetworkError.badUrl)
            return
        }
        
        print(url.absoluteURL)
        
        getRequesWith(type: Forecast.Forecast.self, url: url) { [weak self] result in
            
            switch result {
            case .success(let forcast):
                self?.fetchForecastSuccess(forcast: forcast)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
}
