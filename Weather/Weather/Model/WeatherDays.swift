//
//  WeatherSevenDays.swift
//  Weather
//
//  Created by Кирилл Коновалов on 9.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import ObjectMapper

struct TempStructure {
    var dt: Double = 0.0
    var temp: Temp
    var humidity: Int
    var weatherMain: String
    
    init(dt: Double, temp: Temp, humidity: Int, weatherMain: String) {
        self.dt = dt
        self.temp = temp
        self.humidity = humidity
        self.weatherMain = weatherMain
    }
    
    static func getDefault() -> TempStructure {
        return TempStructure.init(dt: 2, temp: Temp(day: 0.0, min: 0.0, max: 0.0), humidity: 0, weatherMain: "Rain")
    }
}

struct Temp {
    var day: Double = 0.0
    var min: Double = 0.0
    var max: Double = 0.0
}

// MARK: - Mapper
class TempStructureMapper: Mappable {
    var dt: Double?
    var temp: TempMapper?
    var humidity: Int?
    var weatherMain: String?

    required init?(map: Map) {
        // ...
    }

    func mapping(map: Map) {
        self.dt <- map["dt"]
        self.temp <- map["temp"]
        self.humidity <- map["humidity"]
        self.weatherMain <- map["weather.0.main"]
    }
}

class TempMapper: Mappable {
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    
    required init?(map: Map) {
        // ...
    }

    func mapping(map: Map) {
        self.temp <- map["day"]
        self.tempMin <- map["min"]
        self.tempMax <- map["max"]
    }
}
