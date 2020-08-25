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
    @ObservedObject var weatherVM: CurrentWeatherViewModel
    @ObservedObject var sevemDaysVM: DaysWeatherViewModel
    @State var selected = 0
    @State var weathers: TempStructure = TempStructure.getDefault()
    @State private var showDatail = false
    @State private var showSearch = false
    
    var detailSize = CGSize(width: 0, height: UIScreen.main.bounds.height)
    
    var body: some View {
        VStack {
            if selected == 0 {
                NavBarView(country: "Moscow", showSearch: self.$showSearch)
            } else {
                NavBarView(country: "Saint Petersburg", showSearch: self.$showSearch)
            }
            
            Picker("", selection: $selected) {
                Text("Moscow").tag(0)
                Text("Saint Petersburg").tag(1)
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
    }
    
    func getTemp() -> some View {
        var temp: [TempStructure]
        if selected == 0 {
            self.sevemDaysVM.fetchWeatherMoscow()
            temp = $sevemDaysVM.tempMoscow.wrappedValue
        } else {
            self.sevemDaysVM.fetchWeatherSaintPetersburg()
            temp = $sevemDaysVM.tempSaintPetersburg.wrappedValue
        }
        
        return HStack(spacing: 20) {
            ForEach(temp, id: \.dt) { random in
                SmallCardView(weathers: random, selected: self.$selected, sevemDaysVM: DaysWeatherViewModel()).onTapGesture {
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
        ContentView(weatherVM: CurrentWeatherViewModel(), sevemDaysVM: DaysWeatherViewModel())
    }
}
