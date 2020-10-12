//
//  TemperatureUnit + Extensions.swift
//  Weather
//
//  Created by Кирилл Коновалов on 9.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

extension TemperatureUnit {
    var title: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
}
