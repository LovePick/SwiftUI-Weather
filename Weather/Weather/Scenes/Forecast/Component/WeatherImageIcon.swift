//
//  WeatherImageIcon.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import SwiftUI

struct WeatherImageIcon: View {
    @State var icon:String
    
    var body: some View {
        AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(icon)@4x.png"), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))){ phase in
            
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
                    .transition(.scale)
                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                
            case .failure(_):
                Image(systemName: "cloud.sun.fill")
                    .foregroundColor(Color("mediumPurple"))
                    .font(.system(size: 40, weight: .bold,design: .rounded))
                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
            case .empty:
                Image(systemName: "cloud.sun.fill")
                    .foregroundColor(Color("mediumPurple"))
                    .font(.system(size: 40, weight: .bold,design: .rounded))
                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
            @unknown default:
                ProgressView()
            }
            
        }//: Image
    }
}

struct WeatherImageIcon_Previews: PreviewProvider {
    static var previews: some View {
        WeatherImageIcon(icon: "04n")
    }
}
