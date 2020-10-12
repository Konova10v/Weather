//
//  MainCardView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 8.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct MainCardView: View {
// MARK: - Parametrs
    @Binding var selected: Int
    @ObservedObject var weatherVM: CurrentWeatherViewModel
    let defaults = UserDefaults.standard
    
// MARK: - UI
    var body: some View {
        ZStack {
            Image("card-bg")
                .resizable().aspectRatio(contentMode: .fill)
            
            VStack(spacing: 5) {
                if !weatherVM.temperature.isEmpty {
                    Text("\(weatherVM.temperature)°")
                    .foregroundColor(Color.white)
                    .fontWeight(Font.Weight.heavy)
                    .font(Font.system(size: 70))
                }
                
                Text("\(weatherVM.icon)")
                    .foregroundColor(Color.white)
                    .fontWeight(Font.Weight.heavy)
                    .font(Font.system(size: 20))
                
                Image("\(weatherVM.icon)")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                
                HStack(spacing: 20) {
                    Text("\(weatherVM.temperatureMin)°")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding(.vertical)
                    
                    Text("\(weatherVM.temperatureMax)°")
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
        .background(Color("mainCard"))
        .onAppear() {
            if self.selected == 0 {
                self.weatherVM.fetchWeatherMoscow()
            } else if self.selected == 1{
                self.weatherVM.fetchWeatherSaintPetersburg()
            } else {
                self.weatherVM.fetchWeather(city: self.weatherVM.city)
            }
        }
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCardView(selected: .constant(0), weatherVM: CurrentWeatherViewModel())
    }
}
