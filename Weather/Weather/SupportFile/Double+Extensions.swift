//
//  Double+Extensions.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

extension Double {
    func toFahrenheit() -> Double {
        // current temperature is always in Kelvin
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        // convert to fahrenheit from Kelvin
        let convertedTemperature = temperature.converted(to: .fahrenheit)
        return convertedTemperature.value
    }
    
    func toCelsius() -> Double {
        // current temperature is always in Kelvin
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        // convert to fahrenheit from Kelvin
        let convertedTemperature = temperature.converted(to: .celsius)
        return convertedTemperature.value
    }
}
