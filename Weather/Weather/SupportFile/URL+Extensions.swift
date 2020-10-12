//
//  URL+Extensions.swift
//  Weather
//
//  Created by Кирилл Коновалов on 9.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

extension URL {
    static func urlForWeatherFor(_ city: String) -> URL? {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(ServerAPI.apiID)") else {
            return nil
        }
        return url
    }
}
