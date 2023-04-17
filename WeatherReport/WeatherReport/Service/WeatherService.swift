//
//  WeatherService.swift
//  WeatherReport
//
//  Created by Harish Kumar on 15/04/23.
//

import Foundation

class WeatherService :  NSObject {
        
    func getWeatherData(url: URL,
                        completion : @escaping (WeatherModel) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let response = try! jsonDecoder.decode(WeatherModel.self, from: data)
                completion(response)
            }
        }.resume()
    }
}
