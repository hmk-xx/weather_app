//
//  WeatherViewModel.swift
//  WeatherReport
//
//  Created by Harish Kumar on 15/04/23.
//

import Foundation

class WeatherViewModel : NSObject {
    
    private var weatherService : WeatherService!
    private(set) var weatherData : WeatherModel! {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    var bindWeatherViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.weatherService =  WeatherService()
    }
    
    // Fetch weather data for selected location
    /// Parameters
    /// city - String (selected city will pass for which we want to check weather)
    func getCityWeatherData(city: String) {
        // Api source url based on selected location
        let sourcesURL = URL(string: String(format: "%@?q=%@,usa&APPID=cc860411a57ab32e3e123e66046dbed0", Constants.Url.baseUrlApi, city))!
        // Service Layer method calling to get selected location data
        self.weatherService.getWeatherData(url: sourcesURL) { (weatherData) in
            self.weatherData = weatherData
        }
    }
    
    // Cities list
    func getCityList() -> [String] {
        return ["Florida", "Miami", "Newyork", "Texas", "California", "Chicago", "Austin"]
    }
}
