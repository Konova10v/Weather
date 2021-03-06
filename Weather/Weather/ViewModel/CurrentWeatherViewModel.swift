//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by Кирилл Коновалов on 8.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

enum TemperatureUnit: String, CaseIterable {
    case celsius
    case fahrenheit
}

enum LoadingState {
    case none
    case loading
    case success
    case failed
}

class CurrentWeatherViewModel: ObservableObject {
    @Published private var weather: WeatherResponse?
    @Published var temperatureUnit: TemperatureUnit = .celsius
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    let defaults = UserDefaults.standard
    
    var city: String {
        let city = self.defaults.string(forKey: "myCity")
        return city!
    }
    
    var temperature: String {
        guard let temp = weather?.main.temp else { return "N/A"}
        
        switch temperatureUnit {
        case .celsius:
            return String(format: "%.0F C", temp.toCelsius())
        case .fahrenheit:
            return String(format: "%.0F F", temp.toFahrenheit())
        }
    }
    
    var temperatureMin: String {
        guard let temp = weather?.main.tempMin else { return "N/A"}
        
        switch temperatureUnit {
        case .celsius:
            return String(format: "%.0F C", temp.toCelsius())
        case .fahrenheit:
            return String(format: "%.0F F", temp.toFahrenheit())
        }
    }
    
    var temperatureMax: String {
        guard let temp = weather?.main.tempMax else { return "N/A"}
        
        switch temperatureUnit {
        case .celsius:
            return String(format: "%.0F C", temp.toCelsius())
        case .fahrenheit:
            return String(format: "%.0F F", temp.toFahrenheit())
        }
    }
    
    var humidity: String {
        guard let humidity = weather?.main.humidity else { return "N/A" }
        return String(format: "%.0F %%", humidity)
    }
    
    var icon: String {
        guard let icon = weather?.weather[0] else { return "Atmosphere" }
        return icon.main
    }
    
    // данные текщей погоды в Москве
    func fetchWeatherMoscow() {
        WeatherService().getCurrentWeatherMoscow { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weather = weather
                }
            case .failure(_):
                return
            }
        }
    }
    
    // данные текщей погоды в Санкт-Петербург
    func fetchWeatherSaintPetersburg() {
        WeatherService().getCurrentWeatherSaintPetersburg { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weather = weather
                }
            case .failure(_):
                return
            }
        }
    }
    
    // данные текщей погоды в городе по поиску
    func fetchWeather(city: String) {
        
        guard let city = city.escaped() else {
            DispatchQueue.main.async {
                self.message = "City is incorrect"
            }
            return
        }
        
        self.loadingState = .loading
        
        WeatherService().getSearchWeather(city: city) { result in
            switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.weather = weather
                        self.loadingState = .success
                        self.defaults.set(city, forKey: "myCity")
                        self.defaults.synchronize()
                    }
                case .failure(_ ):
                    DispatchQueue.main.async {
                        self.message = "Unable to find weather"
                        self.loadingState = .failed
                }
            }
        }
    }
}
