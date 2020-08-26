//
//  WeatherService.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

class WeatherService {
    /// текущая погода в Москве
    func getCurrentWeatherMoscow(completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void) {
        guard let url = ServerAPI.moscow else { return completion(.failure(.badUrl))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let response = try?
                JSONDecoder().decode(WeatherResponse.self, from: data)
            if let response = response {
                completion(.success(response))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    /// текущая погода в Санкт-Петербург
    func getCurrentWeatherSaintPetersburg(completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void) {
        guard let url = ServerAPI.saintPetersburg else { return completion(.failure(.badUrl))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let response = try?
                JSONDecoder().decode(WeatherResponse.self, from: data)
            if let response = response {
                completion(.success(response))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    /// погода в Москве за несколько дней
    public func getMoscowDaysWeather(callback: @escaping (_ meters: [TempStructure]) -> Void ) {
        
        let url = ServerAPI.moscowWeatherDay
        
        APICallManager.shared.createRequest(url, method: .get, headers: nil, parameters: nil, onSuccess: { (responseObject: JSON) -> Void in
            if let cocktailList = responseObject["daily"].arrayObject as? [[String : Any]] {
                if let mapped: [TempStructureMapper] = Mapper<TempStructureMapper>().mapArray(JSONObject: cocktailList) {
                    let meters = WeatherService.self.convertMeters(meters: mapped)
                    callback(meters)
                }
            }
            
        }, onFailure: {(errorMessage: String) -> Void in
            print("error")
        })
    }
    
    /// погода в Санкт-Петербург за несколько дней
    public func getSaintPetersburgDaysWeather(callback: @escaping (_ meters: [TempStructure]) -> Void ) {
        
        let url = ServerAPI.saintPetersburgWeatherDay
        
        APICallManager.shared.createRequest(url, method: .get, headers: nil, parameters: nil, onSuccess: { (responseObject: JSON) -> Void in
            if let cocktailList = responseObject["daily"].arrayObject as? [[String : Any]] {
                if let mapped: [TempStructureMapper] = Mapper<TempStructureMapper>().mapArray(JSONObject: cocktailList) {

                    let meters = WeatherService.self.convertMeters(meters: mapped)
                    callback(meters)
                }
            }
            
        }, onFailure: {(errorMessage: String) -> Void in
            print("error")
        })
    }
    
    /// поиск текущей погоды на названию города
    func getSearchWeather(city: String,completion: @escaping (Result<Main?, NetworkError>) -> Void) {
        
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

extension WeatherService {
    fileprivate class func convert(meter: TempStructureMapper) -> TempStructure? {
        guard let dt = meter.dt, let temp = self.convertTemp(meter: meter.temp!), let humidity = meter.humidity, let weatherMain = meter.weatherMain else { return nil }
        return TempStructure(dt: dt, temp: temp, humidity: humidity, weatherMain: weatherMain)
    }
    
    fileprivate class func convertTemp(meter: TempMapper) -> Temp? {
        guard let temp = meter.temp, let tempMin = meter.tempMin, let tempMax = meter.tempMax  else { return nil }
        return Temp(day: temp, min: tempMin, max: tempMax)
    }
    
    fileprivate class func convertMeters(meters: [TempStructureMapper]) -> [TempStructure] {
        var arr = Array<TempStructure>()
        for met in meters {
            if let meter = self.convert(meter: met) {
                arr.append(meter)
            } else {
                continue
            }
        }
        return arr
    }
}

