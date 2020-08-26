//
//  DaysWeatherViewModel.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

class DaysWeatherViewModel: ObservableObject {
    @Published var temperatureUnit: TemperatureUnit = .celsius
    @Published var isVisible: Bool = false
    
    var tempMoscow: [TempStructure] = [TempStructure]()
    var tempSaintPetersburg: [TempStructure] = [TempStructure]()
    
    func fetchWeatherMoscow() {
        WeatherService().getMoscowDaysWeather { (temp) in
            self.tempMoscow = temp
        }
    }
    
    func fetchWeatherSaintPetersburg() {
        WeatherService().getSaintPetersburgDaysWeather { (temp) in
            self.tempSaintPetersburg = temp
        }
    }
}
