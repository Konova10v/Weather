//
//  ContentView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 21.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

import SwiftUI
struct ContentView: View {
    @State var selected = 0
    
     @State private var weather =  WeatherData(id: 1, day: "Monday", weatherIcon: "sun.max", currentTemp: "50", minTemp:"52", maxTemp: "69", color: "mainCard")
    
    
    @State private var showDatail = false
    @State private var showSearch = false
    
    private var detailSize = CGSize(width: 0, height: UIScreen.main.bounds.height)
    
    @State private var sampleData = WeatherData.sampleData
    
    var body: some View {
        VStack {
            NavBarView(country: "Russia", showSearch: self.$showSearch)
            
            Picker("", selection: $selected) {
                Text("Today").tag(0)
                Text("Tomorow").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            
            
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    MainCardView(weather: $weather, weatherVM: CurrentWeatherViewModel())
                    .cornerRadius(CGFloat(20))
                    .padding()
                    .shadow(color: Color(self.weather.color)
                    .opacity(0.4), radius: 20, x: 0, y: 0)
                    
                    Text("Next 7 days").foregroundColor(Color("text"))
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(WeatherData.sampleData, id: \.id) { weather in
                                SmallCard(weather: weather).onTapGesture {
                                    withAnimation(.spring()) {
                                        self.showDatail.toggle()
                                        self.weather = weather
                                    }
                                }
                            }
                        }
                        .frame(height: 380)
                        .padding(.horizontal)
                    }
                    .frame(height: 350, alignment: .top)
                }
                DetailView(weather: self.$weather, showDetails: self.$showDatail)
                    .offset(self.showDatail ? CGSize.zero : detailSize)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
