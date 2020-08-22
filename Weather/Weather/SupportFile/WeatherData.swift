//
//  WeatherData.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import SwiftUI

struct WeatherData: Hashable, Identifiable {
    let id: Int
    let day: String
    let weatherIcon: String
    let currentTemp: String
    let minTemp: String
    let maxTemp: String
    let color: String
    
    static var sampleData: [WeatherData] {
        return [
            WeatherData(id: 1, day: "Monday", weatherIcon: "sun.max", currentTemp: "50", minTemp: "52", maxTemp: "69", color: "mainCard"),
            WeatherData(id: 2, day: "Tuesday", weatherIcon: "sun.dust", currentTemp: "33", minTemp: "52", maxTemp: "69", color: "tuesday"),
            WeatherData(id: 3, day: "Wednesday", weatherIcon: "cloud.sun.rain", currentTemp: "38", minTemp: "52", maxTemp: "59", color: "wednesday"),
            WeatherData(id: 4, day: "Thursday", weatherIcon: "cloud.sun.bolt", currentTemp: "33", minTemp: "52", maxTemp: "60", color: "thursday"),
            WeatherData(id: 5, day: "Friday", weatherIcon: "sun.haze", currentTemp: "40", minTemp: "52", maxTemp: "69", color: "friday"),
            WeatherData(id: 6, day: "Saturday", weatherIcon: "sun.dust", currentTemp: "50", minTemp: "52", maxTemp: "38", color: "saturday"),
            WeatherData(id: 7, day: "Sunday", weatherIcon: "sun.max", currentTemp: "50", minTemp: "52", maxTemp: "69", color: "sunday")
        ]
    }
}
