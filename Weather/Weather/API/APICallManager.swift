//
//  APICallManager.swift
//  Weather
//
//  Created by Кирилл Коновалов on 21.08.2020.
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

