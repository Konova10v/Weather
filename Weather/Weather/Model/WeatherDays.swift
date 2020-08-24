//
//  WeatherSevenDays.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

struct WeatherDays: Hashable {
    var date: String = ""
    
    init (json: [String: Any]) {
        if let date = json["dt"] { self.date = "\(date)" }
    }
    
    static func getModels(_ json: [[String : Any]]) -> [WeatherDays] {
        return json.map { WeatherDays(json: $0)}
    }
    
    static func getDefault() -> WeatherDays {
        let data: [String: Any] = [
            "dt": "25.05.2020"]
        
        return WeatherDays(json: data)
    }
}
