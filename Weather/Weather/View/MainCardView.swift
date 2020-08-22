//
//  MainCardView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct MainCardView: View {
    @Binding var weather: WeatherData
    @ObservedObject var weatherVM: CurrentWeatherViewModel
    
    var body: some View {
        ZStack {
            Image("card-bg")
                .resizable().aspectRatio(contentMode: .fill)
            
            VStack(spacing: 5) {
                Text("\(weather.currentTemp)°")
                    .foregroundColor(Color.white)
                    .fontWeight(Font.Weight.heavy)
                    .font(Font.system(size: 70))
                Image(systemName: weather.weatherIcon)
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                
                HStack(spacing: 20) {
                    Text("\(weather.maxTemp)°")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding(.vertical)
                    
                    Text("\(weather.maxTemp)°")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding(.vertical)
                }
                
                Picker(selection: self.$weatherVM.temperatureUnit, label: Text("Select a Unit")) {
                    ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                        Text(unit.title)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300, height: 30, alignment: .center)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(weather.color))
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCardView(weather: .constant(WeatherData.sampleData[0]), weatherVM: CurrentWeatherViewModel())
    }
}
