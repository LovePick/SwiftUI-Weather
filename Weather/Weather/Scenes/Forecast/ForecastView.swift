//
//  ForecastView.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import SwiftUI

protocol ForecastViewDisplayLogic {
    var interactor: ForecastBusinessLogic? {get set}
    func updateWithForecast(model: ForecastModel.ViewModel)
    func updateWithError(error: NetworkError)
}
struct ForecastView: View, ForecastViewDisplayLogic {
    // MARK: - PROPERTY
    var interactor: ForecastBusinessLogic?
    @State var city: Coordinates.Coordinate
    @State var weather: CurrentWeather.CurrentWeather
    @Binding var detail: WeatherDetailmodel
    
    @ObservedObject private var model = ForecastDataStore()
    
    // MARK: - BODY
    var body: some View {
        VStack() {

            VStack(){
                
                ForecastHeader(city: city, weather: weather, detail: $detail)
            }//: VSTACK HEADER
            .background(
                backgroundGradient
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                    .ignoresSafeArea(.all)
            )
                
            
            if model.forecast.forecast.count > 0 {
                List {
                    ForEach(model.forecast.forecast) { day in
                        
                        Section(header: Text(day.date) ) {
                            ForEach(day.item) { item in
                                HStack {
                                    WeatherImageIcon(icon: item.icon)
                                    .frame(maxWidth: 40)
                                    
                                    VStack(alignment: .leading, spacing: 8){
                                        Text(item.dt_txt)
                                            .font(.system(.footnote, design: .rounded))
                                            .foregroundColor(Color.gray)
                                        
                                        HStack(){
                                            Text(item.main)
                                                .font(.system(.headline, design: .rounded))
                                                .foregroundColor(Color.black)
                                        
                                        }//: HSTACK
                                    
                                    }//: VSTACK
                                    
                                    Spacer()
                                    
                                    Text(tempDisplay(temp: item.temp, selectUnit: detail.selectUnit))
                                        .font(.system(.title, design: .rounded))
                                        .foregroundColor(Color.black)
                                    
                                }//: HSTACK
                            }
                        }//: SECTION
                        
                        
                    }// LOOP
                    .listRowBackground(Color.white)
                }//: List
                .background {
                    Color.clear
                }
                .scrollContentBackground(.hidden)
            } else {
                Image(systemName: "cloud.sun.fill")
                    .imageModifier()
                    .foregroundColor(Color("iris"))
                    .padding()
            }
            Spacer()
            
        }//: VSTACK
        .background(
            Color("antiFlashWhite")
                .ignoresSafeArea(.all)
        )
        .onAppear() {
            interactor?.fetchWeatherforcast(request: ForecastModel.FetchForecast.Request(lat: city.lat, lon: city.lon))
        }
    }
}

// MARK: - ACTION
extension ForecastView {
    
    func tempDisplay(temp:Double, selectUnit: TodayModel.TempUnit) -> String {
        var value = 0.0
        switch(selectUnit){
        case .f:
            value = convertTempKelvinToFaranheit(kelvin: temp)
        case .c:
            value = convertTempKelvinToCelsius(kelvin: temp)
        }
        
        let str = "\(String(format: "%.1f", value)) °\(selectUnit.rawValue)"
        return str
    }
}

// MARK: - ForecastViewDisplayLogic
extension ForecastView {
    func updateWithForecast(model: ForecastModel.ViewModel) {
        
        self.model.forecast = model
    }
    
    func updateWithError(error: NetworkError) {
        
    }
}
// MARK: - PREVIEW
struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(city: Coordinates.Coordinate(name: "London", localNames: ["af": "Londen"], lat: 51.5085, lon: -0.1257, country: "GB", state: ""), weather: CurrentWeather.CurrentWeather(coord: CurrentWeather.Coord(lon: 51.5085, lat: -0.1257), weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: "London", cod: nil), detail: .constant(WeatherDetailmodel(selectUnit: .c, tempKelvin: 100, windSpeed: 10, humidity: 10, icon: "04d", main: "")))
    }
}
