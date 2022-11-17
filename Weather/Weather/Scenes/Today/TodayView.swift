//
//  TodayView.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import SwiftUI
protocol TodayViewDisplayLogic {

    var interactor: TodayBusinessLogic? {get set}
    func updateSearchResult(cityList: Coordinates.Coordinates)
    func updateWeatherResult(weather: CurrentWeather.CurrentWeather)
    func updateError(error: NetworkError)
    
}

struct TodayView: View, TodayViewDisplayLogic {
    
    // MARK: - PROPERTY
    var interactor: TodayBusinessLogic?
    
    @State private var placeholder = "city name, state code, country code"
    @State private var query = ""
    @State private var dateToday = ""
    @ObservedObject private var model = WeatherDataStore()
    @State private var selectCity: Coordinates.Coordinate?
    @State private var isShowingDetailView = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
        
            ZStack() {
             
                if (model.currentWeather != nil ){
                    VStack(){
                        Text(selectCity?.name ?? "")
                            .foregroundColor(Color.white)
                            .font(.system(.title, design: .rounded))
                            .padding(.top, 150)
                        
                        WeathereDetailView(model: $model.cityWeather)
 
                    }//: VSTACK

                } else {
                    Image(systemName: "cloud.sun.fill")
                        .imageModifier()
                        .foregroundColor(Color.white)
                        .padding()
                        
                }
                
                VStack(alignment: .center) {
                    
                    HStack() {
                        Text(dateToday)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color("antiFlashWhite"))
            
                        Spacer()
                        
                        if( model.currentWeather != nil ) {
                            NavigationLink {
                                ForecastView(city: selectCity ?? Coordinates.Coordinate(name: "London", localNames: ["af": "Londen"], lat: 51.5085, lon: -0.1257, country: "GB", state: ""), weather: model.currentWeather!, detail: $model.cityWeather).configureView()
                                
                            } label: {
                                Label("Forecast", systemImage: "arrow.up.left.and.arrow.down.right.circle")
                                    .foregroundColor(.white)
                            }
                        }
                        

                    }
                    .padding()
                    
                    
                    SearchBarView(searchText: $query, placeholder: $placeholder)
                        .padding(.horizontal)
                        .onChange(of: query) { newValue in
                            searchCity(keyword: newValue)
                        }
                    
                    if model.displaySearchCity.count > 0 {
                        List(){
                            ForEach(model.displaySearchCity, id: \.self) { item in
                                
                                Button {
                                    selectCity(city: item)
                                } label: {
                                    HStack(spacing: 8){
                                        Image(systemName: "mappin.and.ellipse")
                                            .foregroundColor(.black)
                                        
                                        Text("\(item.name), \(item.state)")
                                            .foregroundColor(.black)
                                    }//: HSTACK
                                }//:BUTTON

                            }//: LOOP
                        }//: LIST
                        .padding(.top, -20)
                        .background {
                            Color.clear
                        }
                        .scrollContentBackground(.hidden)
                        
                    }//: CONDITION SEARCH
                    
                    Spacer()
                }//: VSTACK
                
            }//: ZSTACK
            .background(
                backgroundGradient
                    .ignoresSafeArea(.all)
            )
            .onAppear() {
                dateToday = getDateToday()
                
                if(selectCity == nil){
                    mockCity()
                }
            }
           
        }//: NAVIGATIONVIEW
        .accentColor(.white)
    }
}

// MARK: - ACTION
extension TodayView {
    func searchCity(keyword: String) {
        if(keyword != "") {
            print(keyword)
            interactor?.fetchCityLocation(city: keyword)
        } else {
            self.model.displaySearchCity = []
        }
    }
    
    
    func selectCity(city:Coordinates.Coordinate) {
        selectCity = city
        UIApplication.shared.endEditing()
        self.query = ""
        self.placeholder = "\(city.name), \(city.state)"
        self.model.displaySearchCity = []
        interactor?.fetchWether(cityModel: city)
        print(self.placeholder)
    }
    
    func getDateToday()->String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    
    func mockCity() {
        let city = Coordinates.Coordinate(name: "Bangkok", localNames: ["th": "กรุงเทพมหานคร"], lat: 13.7524938, lon: 100.4935089, country: "TH", state: "Bangkok")
        selectCity = city
        interactor?.fetchWether(cityModel: city)
    }
}

// MARK: - TodayViewDisplayLogic
extension TodayView {
    func updateSearchResult(cityList: Coordinates.Coordinates) {
        self.model.displaySearchCity = cityList
    }
    
    func updateWeatherResult(weather: CurrentWeather.CurrentWeather) {
        self.model.currentWeather = weather
        
        let temp = weather.main?.temp
        let win = weather.wind?.speed
        let humodity = weather.main?.humidity
        let icon = weather.weather?.first?.icon
        let main = weather.weather?.first?.main
        
        self.model.cityWeather = WeatherDetailmodel(selectUnit: model.selectUnit, tempKelvin: temp ?? 0, windSpeed: win ?? 0, humidity: humodity ?? 0, icon: icon ?? "02d", main: main ?? "")
    }
    
    func updateError(error: NetworkError) {
        self.model.currentWeather = nil
    }
}

// MARK: - PREVIEW
struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView().configureView()
    }
}
