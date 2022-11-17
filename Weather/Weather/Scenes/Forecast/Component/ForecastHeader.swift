//
//  ForecastHeader.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import SwiftUI

struct ForecastHeader: View {
    // MARK: - PROPERTY
    @State var city: Coordinates.Coordinate
    @State var weather: CurrentWeather.CurrentWeather
    @Binding var detail: WeatherDetailmodel
    
    // MARK: - BODY
    var body: some View {
        VStack(){
            
            HStack(spacing: 40) {
                
                VStack(alignment: .leading, spacing: 10) {
        

                    Text("\(city.name), \(city.state), \(city.country)")
                        .lineLimit(nil)
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(Color("antiFlashWhite"))
                    
                    Button {
                        swithTemperatureUnit()
                    } label: {
                        Text("\(String(format: "%.1f", detail.tempDisplay)) °\(detail.selectUnit.rawValue)")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .disabled(true)
                    
                    
                        
                }//: VSTACK
                
              Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    
                    AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(detail.icon)@4x.png"), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))){ phase in
                        
                        switch phase {
                        case .success(let image):
                            image
                                .imageModifier()
                                .transition(.scale)
                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                            
                        case .failure(_):
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(Color.white)
                                .font(.system(size: 40, weight: .bold,design: .rounded))
                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                        case .empty:
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(Color.white)
                                .font(.system(size: 40, weight: .bold,design: .rounded))
                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                        @unknown default:
                            ProgressView()
                        }
                        
                    }//: Image
                    .frame(maxWidth: 100)
                    .background(
                        HStack {
                            ZStack{
                                Circle()
                                    .fill(Color("iris").opacity(0.15))
                                    
                                
                                Circle()
                                    .fill(Color.black.opacity(0.10))
                                    .padding(10)
                                
                            }//: ZSTACK
                        }//: HSTACK
                          
                    )
                }
                
            }//: HSTACK
            
            
        }//: VSTACK
        .padding()
        
        
        
        
    }
}

extension ForecastHeader {
    func swithTemperatureUnit(){
        switch(detail.selectUnit){
        case .f:
            detail.selectUnit = .c
        case .c:
            detail.selectUnit = .f
        }
        
    }
    
}
struct ForecastHeader_Previews: PreviewProvider {
    static var previews: some View {
        ForecastHeader(city: Coordinates.Coordinate(name: "London", localNames: ["af": "Londen"], lat: 51.5085, lon: -0.1257, country: "GB", state: ""), weather: CurrentWeather.CurrentWeather(coord: CurrentWeather.Coord(lon: 51.5085, lat: -0.1257), weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: "London", cod: nil), detail: .constant(WeatherDetailmodel(selectUnit: .c, tempKelvin: 295.45, windSpeed: 0, humidity: 0, icon: "10d", main: "Rain")))
            .previewLayout(.sizeThatFits)
    }
}
