//
//  APICallManager.swift
//  Weather
//
//  Created by Кирилл Коновалов on 8.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/// enum с перечеслинение API-endpoints
enum ServerAPI {
    static var baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather")
    static var apiID = "e9ff8714a0cb2180a4799993010ab13a"
    static var moscow = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=\(ServerAPI.apiID)")
    static var saintPetersburg = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Minsk&appid=\(ServerAPI.apiID)")
    static var moscowWeatherDay =  "https://api.openweathermap.org/data/2.5/onecall?lat=55.751244&lon=37.618423&exclude=current,minutely,hourly&appid=\(ServerAPI.apiID)"
    static var saintPetersburgWeatherDay =  "https://api.openweathermap.org/data/2.5/onecall?lat=53.9&lon=27.57&exclude=current,minutely,hourly&appid=\(ServerAPI.apiID)"
    
}

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class APICallManager {
    static let shared = APICallManager()
    
    var decoder: JSONDecoder {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        return decode
    }

    func createRequest(
        _ url: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: AnyObject?,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
    ) {
        AF.request(url, method: method).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    callback(error.localizedDescription)
                }
            }
        }
    }
}
