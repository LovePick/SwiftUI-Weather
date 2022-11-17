//
//  TodayInteractorTests.swift
//  WeatherTests
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import XCTest

@testable import Weather

class TodayInteractorTests: XCTestCase {

    var sut: TodayInteractor!
    var presenterSpy: TodayPresenterSpy!
    var config: Configuration!
    
    override func setUp() {
        super.setUp()
        setenv("ENV", "TEST", 1)
        
        config = Configuration()
        sut = TodayInteractor(config: config)
        presenterSpy = TodayPresenterSpy()
        
        sut.presenter = presenterSpy
    }
    
    // MARK: - Test doubles
    class TodayPresenterSpy: TodayPresentationLogic {
        var cityList: Coordinates.Coordinates?
        var currentWeather: CurrentWeather.CurrentWeather?
        var error: NetworkError?
        
        var view: Weather.TodayViewDisplayLogic?
        
        func presentCityList(response: Weather.TodayModel.FetchCity.Response) {
            cityList = response.coordinates
        }
        
        func presentCurrentWeather(response: Weather.TodayModel.FetchWeather.Response) {
            currentWeather = response.weather
        }
        
        func presentError(response: Weather.NetworkError) {
            error = response
        }
        
        
    }
    
    // MARK: - Tests
    func testFetchCityList() {
        sut.fetchCityLocation(city: "London")
        DispatchQueue.main.async { [weak self] in
            XCTAssertNotNil(self?.presenterSpy.cityList)
        }
        
    }
}
