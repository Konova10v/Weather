//
//  WeatherService.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    
    func getCurrentWeatherSaintPetersburg(completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        guard let url = ServerAPI.saintPetersburg else { return completion(.failure(.badUrl))}
        
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
    
    public func getDaysWeather(onSuccess successCallback: ((_ response: [WeatherDays]) -> Void)?,
                               onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        let url = ServerAPI.moscowSevenDay
        
        APICallManager.shared.createRequest(url, method: .get, headers: nil, parameters: nil, onSuccess: { (responseObject: JSON) -> Void in
            var data = [WeatherDays]()
            if let cocktailList = responseObject["daily"].arrayObject as? [[String : Any]] {
                data = WeatherDays.getModels(cocktailList)
            }
            successCallback?(data)
            
        }, onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        })
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

