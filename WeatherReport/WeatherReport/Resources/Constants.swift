//
//  Constants.swift
//  WeatherReport
//
//  Created by Harish Kumar on 15/04/23.
//

import Foundation

struct Constants {
    
    static let emptyString = ""
    static let imageExtension = "@2x.png"
    
    struct Url {
        static let baseUrlImage = "https://openweathermap.org/img/wn/"
        static let baseUrlApi = "https://api.openweathermap.org/data/2.5/weather"
    }
    
    struct CellIdentifier {
        static let cityTableViewCell = "CityTableViewCell"
        static let baseUrlApi = "https://api.openweathermap.org/data/2.5/weather"
    }
    
    struct UserDefaults {
        static let selectedCity = "SelectedCity"
    }
}
