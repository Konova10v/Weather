//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

enum TemperatureUnit: String, CaseIterable {
    case celsius
    case fahrenheit
}

class CurrentWeatherViewModel: ObservableObject {
    @Published private var weather: WeatherResponse?
    @Published var temperatureUnit: TemperatureUnit = .celsius
    
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
}


