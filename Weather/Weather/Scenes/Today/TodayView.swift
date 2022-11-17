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
    
}

struct TodayView: View, TodayViewDisplayLogic {
    
    // MARK: - PROPERTY
    var interactor: TodayBusinessLogic?
    
    @State private var query = ""
    @ObservedObject private var model = WeatherDataStore()
    @State private var selectCity: Coordinates.Coordinate?
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            
            ZStack() {
                VStack(alignment: .center) {
                    SearchBarView(searchText: $query)
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
                                        
                                        Text("\(item.name), \(item.state)")
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
                }
                
            }//: ZSTACK
            .background(
                backgroundGradient
                    .ignoresSafeArea(.all)
            )
           
            
            
        }//: NAVIGATIONVIEW
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
    }
}

// MARK: - TodayViewDisplayLogic
extension TodayView {
    func updateSearchResult(cityList: Coordinates.Coordinates) {
        self.model.displaySearchCity = cityList
        
        
    }
}

// MARK: - PREVIEW
struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView().configureView()
    }
}
