//
//  Weather.swift
//  Weather
//
//  Created by Кирилл Коновалов on 8.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.temp = try container.decode(Double.self, forKey: .temp)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

struct Weather: Decodable {
    let main: String
    
    enum CodingKeys: String, CodingKey {
        case main
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.main = try container.decode(String.self, forKey: .main)
    }
}
