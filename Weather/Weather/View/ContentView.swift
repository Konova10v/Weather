//
//  ContentView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 8.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
// MARK: - Parametrs
    @ObservedObject var weatherVM: CurrentWeatherViewModel
    @ObservedObject var daysWeatherVM: DaysWeatherViewModel
    @State var selected = 0
    @State var weathers: TempStructure = TempStructure.getDefault()
    @State private var showDatail = false
    @State private var showSearch = false
    let defaults = UserDefaults.standard
    
    var detailSize = CGSize(width: 0, height: UIScreen.main.bounds.height)
    
// MARK: - UI
    var body: some View {
        VStack {
            if selected == 0 {
                NavBarView(country: "Moscow", showSearch: self.$showSearch)
            } else if selected == 1 {
                NavBarView(country: "Minsk", showSearch: self.$showSearch)
            } else {
                NavBarView(country: "\(weatherVM.city)", showSearch: self.$showSearch)
            }
            
            Picker("", selection: $selected) {
                Text("Moscow").tag(0)
                Text("Minsk").tag(1)
                Text("Your City").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    if selected == 0 {
                        MainCardView(selected: $selected, weatherVM: CurrentWeatherViewModel())
                            .cornerRadius(CGFloat(20))
                            .padding()
                            .shadow(color: Color("mainCard")
                            .opacity(0.4), radius: 20, x: 0, y: 0)
                    } else {
                        MainCardView(selected: $selected, weatherVM: CurrentWeatherViewModel())
                            .cornerRadius(CGFloat(20))
                            .padding()
                            .shadow(color: Color("mainCard")
                            .opacity(0.4), radius: 20, x: 0, y: 0)
                    }
                    
                    Text("Next days").foregroundColor(Color("text"))
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        getTemp()
                    }
                    .frame(height: 350, alignment: .top)
                }
                DetailView(weathers: self.$weathers, showDetails: self.$showDatail)
                    .offset(self.showDatail ? CGSize.zero : detailSize)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .onAppear(perform: loadData)
    }
    
// MARK: - Functions
    private func loadData() {
        self.daysWeatherVM.fetchWeatherMoscow()
        self.daysWeatherVM.fetchWeatherSaintPetersburg()
    }
    
    func getTemp() -> some View {
        var temp: [TempStructure]
        if selected == 0 {
            temp = $daysWeatherVM.tempMoscow.wrappedValue
        } else if selected == 1 {
            temp = $daysWeatherVM.tempSaintPetersburg.wrappedValue
        } else {
            self.daysWeatherVM.fetchAddWeather(city: weatherVM.city)
            temp = $daysWeatherVM.tempAdd.wrappedValue
        }
        
        return HStack(spacing: 20) {
            ForEach(temp, id: \.dt) { random in
                SmallCardView(weathers: random, daysWeathersVM: DaysWeatherViewModel()).onTapGesture {
                    self.showDatail.toggle()
                    self.weathers = random
                }
            }
        }
        .frame(height: 380)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherVM: CurrentWeatherViewModel(), daysWeatherVM: DaysWeatherViewModel())
    }
}
