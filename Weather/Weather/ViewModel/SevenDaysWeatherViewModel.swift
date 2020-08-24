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
    
    var meters: [TempStructure] = []
    
    func fetchWeatherMoscow() {
        WeatherService().getDaysWeather { (temp) in
            self.meters = temp
        }
    }
}
