//
//  WeatherService.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

class WeatherService {
    func getCurrentWeatherMoscow(completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        guard let url = ServerAPI.moscow else { return completion(.failure(.badUrl))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let response = try?
                JSONDecoder().decode(WeatherResponse.self, from: data)
            if let response = response {
                print(response.main)
                completion(.success(response.main))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getSearchWeather(city: String,completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForWeatherFor(city) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
}

