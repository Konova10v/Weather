//
//  SmallCardView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct SmallCardView: View {
    @State var weathers: TempStructure
    
    var body: some View {
        VStack(spacing: 30) {
            getDate()
            
            Image(systemName: "sun.max")
                .resizable()
                .foregroundColor(Color.white)
                .frame(width: 60, height: 60)
            
            ZStack {
                Image("cloud")
                    .resizable()
                    .scaledToFill()
                    .offset(CGSize(width: 0, height: 30))
                
                getTemp()
            }
        }
        .frame(width: 200, height: 300)
        .background(Color("mainCard"))
        .cornerRadius(30)
        .shadow(color: Color("mainCard").opacity(0.7), radius: 10, x: 0, y: 8)
    }
    
    func getDate() -> some View {
        var localDate: String = ""
        let timeResult = Double(weathers.dt)
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        localDate = dateFormatter.string(from: date)
        return Text(localDate)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .offset(CGSize(width: 0, height: 15))
    }
    
    func getTemp() -> some View {
        var temperature: String {
            let temp = weathers.temp.day
            return String(format: "%.0F C", temp.toCelsius())
        }
        
        var temperatureMin: String {
            let temp = weathers.temp.min
            return String(format: "%.0F C", temp.toCelsius())
        }
        
        var temperatureMax: String {
            let temp = weathers.temp.max
            return String(format: "%.0F C", temp.toCelsius())
        }
        
        return VStack(spacing: 8) {
            Text(temperature)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
            
            HStack {
                Text (temperatureMin)
                    .foregroundColor(Color("light-text"))
                Text(temperatureMax)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView(weathers: TempStructure.getDefault())
    }
}
