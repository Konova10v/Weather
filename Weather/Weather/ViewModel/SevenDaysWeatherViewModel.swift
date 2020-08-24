//
//  SevenDaysWeatherViewModel.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

class SevenDaysWeatherViewModel: ObservableObject {
    @Published var temperatureUnit: TemperatureUnit = .celsius
    @Published var isVisible: Bool = false
    
    var weatherDays: [WeatherDays] = [WeatherDays]()
    
    func fetchWeatherMoscow() {
        WeatherService().getDaysWeather(onSuccess: { (response) in
            self.weatherDays = response
            self.isVisible = true
        }, onFailure: {(message) in
            print("message \(message)")
        })
    }
}
