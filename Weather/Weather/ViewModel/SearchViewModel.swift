//
//  SearchViewModel.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

enum LoadingState {
    case none
    case loading
    case success
    case failed
}

class SearchViewModel: ObservableObject {
    
    @Published private var weather: Weather?
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    @Published var temperatureUnit: TemperatureUnit = .celsius
    
    var temperature: String {
        guard let temp = weather?.temp else {
            return "N/A"
        }
        
        switch temperatureUnit {
            case .celsius:
                return String(format: "%.0F C", temp.toCelsius())
            case .fahrenheit:
                return String(format: "%.0F F", temp.toFahrenheit())
        }
    }
    
    var temperatureMin: String {
        guard let temp = weather?.tempMin else { return "N/A"}
        
        switch temperatureUnit {
        case .celsius:
            return String(format: "%.0F C", temp.toCelsius())
        case .fahrenheit:
            return String(format: "%.0F F", temp.toFahrenheit())
        }
    }
    
    var temperatureMax: String {
        guard let temp = weather?.tempMax else { return "N/A"}
        
        switch temperatureUnit {
        case .celsius:
            return String(format: "%.0F C", temp.toCelsius())
        case .fahrenheit:
            return String(format: "%.0F F", temp.toFahrenheit())
        }
    }
    
    var humidity: String {
        guard let humidity = weather?.humidity else {
            return "N/A"
        }
        return String(format: "%.0F %%", humidity)
    }
    
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
