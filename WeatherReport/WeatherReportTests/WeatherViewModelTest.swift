//
//  WeatherViewModelTest.swift
//  WeatherReport
//
//  Created by Harish Kumar on 15/04/23.
//

import XCTest
@testable import WeatherReport

final class WeatherViewModelTest: XCTestCase {
    
    var sut: WeatherViewModel!
    
    override func setUp() {
      super.setUp()
      sut = WeatherViewModel()
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    func testGetLocationsList() {
        XCTAssertTrue(sut.getLocationsList().count > 0)
    }
    
    func testGetWeatherData() {
        sut.getLocationWeatherData(location: "Miami")
        XCTAssertNil(sut.weatherData)
    }
    
    func testWeatherResponse() throws {
        guard
            let path = Bundle.main.path(forResource: "Weather", ofType: "json")
        else { fatalError("Can't find json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(WeatherModel.self, from: data)
        
        XCTAssertEqual(response.weather?.first?.description, "broken clouds")
        XCTAssertEqual(response.weather?.first?.main, "Clouds")
        XCTAssertEqual(response.main?.tempMax, 300.38)
        XCTAssertEqual(response.main?.tempMin, 299.26)
        XCTAssertEqual(response.main?.humidity, 83)
    }
}
