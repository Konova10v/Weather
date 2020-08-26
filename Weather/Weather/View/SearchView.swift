//
//  SearchView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: Parametrs
    @ObservedObject private var searchWeatherVM: SearchViewModel
    @State private var city: String = ""
    
    init(searchWeatherVM: SearchViewModel = SearchViewModel()) {
        self.searchWeatherVM = searchWeatherVM
    }
    
    // MARK: UI Search
    var body: some View {
        
        VStack {
            
            TextField("Search", text: self.$city, onEditingChanged: { _ in }, onCommit: {
                self.searchWeatherVM.fetchWeather(city: self.city)
                
            }).textFieldStyle(RoundedBorderTextFieldStyle())
               
            Spacer()
            if self.searchWeatherVM.loadingState == .loading {
                LoadingView()
            } else if self.searchWeatherVM.loadingState == .success {
                WeatherView(searchWeatherVM: self.searchWeatherVM)
            } else if self.searchWeatherVM.loadingState == .failed {
                 ErrorView(message: self.searchWeatherVM.message)
            }
            
            Spacer()
           
        }.padding()
    }
}
    // MARK: UI Unable to load
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        let vm = SearchViewModel()
        vm.loadingState = .none
        vm.message = "Unable to load weather"
        
        return SearchView(searchWeatherVM: vm)
    }
}

    // MARK: UI Current Weather
struct WeatherView: View {
    
    @ObservedObject var searchWeatherVM: SearchViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(self.searchWeatherVM.temperature)")
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Text("\(self.searchWeatherVM.humidity)")
                .foregroundColor(Color.white)
                .opacity(0.7)
            
            Picker(selection: self.$searchWeatherVM.temperatureUnit, label: Text("Select a Unit")) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text(unit.title)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            HStack {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: 20, height: 20)
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(100)
            .shadow(radius: 20)
        }
        .padding()
        .frame(width:300, height: 200)
        .background(Color("selected"))
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    
    }
}

    // MARK: Loading
struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading your weather!")
                .font(.body)
                .foregroundColor(Color.white)
          
        }
        .padding()
        .frame(width:300, height: 150)
        .background(Color.orange)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    
    }
}

    // MARK: Error
struct ErrorView: View {
    let message: String
    var body: some View {
       VStack {
           Text(message)
               .font(.body)
               .foregroundColor(Color.white)
         
       }
       .padding()
       .frame(width:300, height: 150)
       .background(Color.red)
       .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
   
   }
}

