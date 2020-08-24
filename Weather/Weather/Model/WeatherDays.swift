//
//  WeatherSevenDays.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import ObjectMapper

struct TempStructure {
    
    var dt: Double = 0.0
    let temp: Temp

    init(dt: Double, temp: Temp) {
        self.dt = dt
        self.temp = temp
    }
    
    static func getDefault() -> TempStructure {
        return TempStructure.init(dt: 2, temp: Temp(day: 0.0, min: 0.0, max: 0.0))
    }
}

struct Temp {
    var day: Double = 0.0
    var min: Double = 0.0
    var max: Double = 0.0
}

class TempStructureMapper: Mappable {

    var dt: Double?
    var temp: TempMapper?

    required init?(map: Map) {
        // ...
    }

    func mapping(map: Map) {
        self.dt <- map["dt"]
        self.temp <- map["temp"]
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


