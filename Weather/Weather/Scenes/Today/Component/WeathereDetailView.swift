//
//  WeathereDetailView.swift
//  Weather
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import SwiftUI

struct WeatherDetailmodel {
    var selectUnit: TodayModel.TempUnit
    var tempKelvin: Double
    var windSpeed: Double
    var humidity: Int
    var icon: String
    var main:String
    
    var tempDisplay: Double {
        var value = 0.0
        switch(selectUnit){
        case .f:
            value = convertTempKelvinToFaranheit(kelvin: tempKelvin)
        case .c:
            value = convertTempKelvinToCelsius(kelvin: tempKelvin)
        }
        return value
    }
}



struct WeathereDetailView: View {
    // MARK: - PROPERTY
    @Binding var model: WeatherDetailmodel
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center){
            
            HStack(spacing: 8) {
                
                Text(String(format: "%0.1f", model.tempDisplay))
                    .foregroundColor(.white)
                    .font(.system(size: 80, weight: .bold,design: .rounded))//: TEXT
                
                Button {
                    swithTemperatureUnit()
                } label: {
                    HStack(alignment: .top) {
                        
                        Image(systemName: "arrow.left.arrow.right.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold,design: .rounded))
                            .padding(.top, 0)
                            .padding(.trailing, -10)
                        
                        Text(model.selectUnit.rawValue)
                            .foregroundColor(.white)
                            .font(.system(size: 80, weight: .bold,design: .rounded))
                    }
                    
                }//: BUTTON
                
                Spacer()
                
            }//: HSTACK
            .zIndex(1)

            HStack(alignment: .center) {
                Spacer()
                
                VStack(alignment: .center){
                    Spacer()
                    
                    AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(model.icon)@4x.png"), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))){ phase in
                        
                        switch phase {
                        case .success(let image):
                            image
                                .imageModifier()
                                .transition(.scale)
                                .frame(minWidth: 150, minHeight: 150, alignment: .center)
                            
                        case .failure(_):
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(Color.white)
                                .font(.system(size: 100, weight: .bold,design: .rounded))
                                .frame(minWidth: 150, minHeight: 150, alignment: .center)
                        case .empty:
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(Color.white)
                                .font(.system(size: 100, weight: .bold,design: .rounded))
                                .frame(minWidth: 150, minHeight: 150, alignment: .center)
                        @unknown default:
                            ProgressView()
                        }
                        
                    }//: Image
                    .background(
                        HStack {
                            ZStack{
                                Circle()
                                    .fill(Color("iris").opacity(0.15))
                                    
                                
                                Circle()
                                    .fill(Color.black.opacity(0.10))
                                    .padding(40)
                                
                            }//: ZSTACK
                        }//: HSTACK
                          
                    )
                    
                    Spacer()
                }//: VSTACK
                .frame(minWidth: 150, minHeight: 150, alignment: .center)
                .padding(.top, -100)
                .zIndex(-1)
                
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Wind")
                        .foregroundColor(Color("antiFlashWhite"))
                        .font(.system(.headline, design: .rounded))
                    
                    Text(String(format: "%.1f", model.windSpeed))
                        .foregroundColor(Color.white)
                        .font(.system(.title, weight: .semibold))
                    
                    
                    
                    Text("Humidt")
                        .foregroundColor(Color("antiFlashWhite"))
                        .font(.system(.headline, design: .rounded))
                        .padding(.top, 20)
                    
                    Text(String(format: "%d%%", model.humidity))
                        .foregroundColor(Color.white)
                        .font(.system(.title, weight: .semibold))
                }//: VSTACK
            }//: HSTACK
            
           
            
            
            Text(model.main)
                .foregroundColor(Color("antiFlashWhite"))
                .font(.system(.title, design: .rounded))
                
            
            Spacer()
            
            
        }//: VSTACK
        .padding()
        
    }
}

// MARK: - ACTION
extension WeathereDetailView {
    func swithTemperatureUnit(){
        switch(model.selectUnit){
        case .f:
            model.selectUnit = .c
        case .c:
            model.selectUnit = .f
        }
        
    }
    
    
}
// MARK: - PREVIEW
struct WeathereDetailView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        
        WeathereDetailView(model: .constant(WeatherDetailmodel(selectUnit: .c, tempKelvin: 0, windSpeed: 0, humidity: 0, icon: "10d", main: "Rain")))
            .background(
                backgroundGradient
            )
    }
}
