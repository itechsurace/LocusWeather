//
//  LSWeatherViewModel.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import Foundation
import UIKit

class LSWeatherViewModel {
    
    var cityName: String?
    var weatherMain: String?
    var weatherDescription: String?
    var temperature: String?
    var feelsLike: String?
    var humidity: String?
    var pressure: String?
    var windSpeed: String?
    var windDirection: String?
    
    var isGridLayout = false
    let listFlowLayout = ListFlowLayout()
    let gridFlowLayout = GridFlowLayout()
    
    func loadForecasts(cityName: String, _ completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        URLLoader.shared.loadForecastData(cityName) { [weak self] result in
            switch result {
            case .success(let forecast):
                guard let strongSelf = self else { return }
                strongSelf.mapModelToViewModel(forecast)
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func mapModelToViewModel(_ forecast: LSWeather) {
        self.cityName = forecast.name
        self.weatherMain = forecast.weather.first?.main
        self.weatherDescription = forecast.weather.first?.weatherDescription
        self.temperature = "\(String(describing: forecast.main.temp))"
        self.feelsLike = "\(String(describing: forecast.main.feelsLike))"
        self.humidity = "\(String(describing: forecast.main.humidity))"
        self.pressure = "\(String(describing: forecast.main.pressure))"
        self.windSpeed = "\(String(describing: forecast.wind.speed))"
        self.windDirection = "\(String(describing: forecast.wind.deg))"
    }
}
