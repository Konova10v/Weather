//
//  DaysWeatherViewModel.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
import CoreLocation

class DaysWeatherViewModel: ObservableObject {
    @Published var temperatureUnit: TemperatureUnit = .celsius
    @Published var isVisible: Bool = false
    
    var tempMoscow: [TempStructure] = [TempStructure]()
    var tempSaintPetersburg: [TempStructure] = [TempStructure]()
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var tempAdd: [TempStructure] = [TempStructure]()
    
    func fetchWeatherMoscow() {
        WeatherService().getMoscowDaysWeather { (temp) in
            self.tempMoscow = temp
        }
    }
    
    func fetchWeatherSaintPetersburg() {
        WeatherService().getSaintPetersburgDaysWeather { (temp) in
            self.tempSaintPetersburg = temp
        }
    }
    
    func fetchAddWeather(city: String) {        
        self.getCoordinateFrom(address: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            DispatchQueue.main.async {
                self.latitude = coordinate.latitude
                self.longitude = coordinate.longitude
                
                WeatherService().getAddDaysWeather(latitude: self.latitude!, longitude: self.longitude!) { (result) in
                    self.tempAdd = result
                }
            }
        }
    }
}

extension DaysWeatherViewModel {
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
