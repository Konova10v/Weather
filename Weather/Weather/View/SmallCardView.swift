//
//  SmallCardView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 23.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct SmallCardView: View {
    @State var weathers: WeatherDays
    
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
                
                VStack(spacing: 8) {
                    Text("0")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                    HStack {
                        Text ("50°")
                            .foregroundColor(Color("light-text"))
                        Text("50°")
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
        .frame(width: 200, height: 300)
        .background(Color("mainCard"))
        .cornerRadius(30)
        .shadow(color: Color("mainCard").opacity(0.7), radius: 10, x: 0, y: 8)
    }
    
    func getDate() -> some View {
        var localDate: String = ""
        if let timeResult = Double(weathers.date) {
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            localDate = dateFormatter.string(from: date)
        }
        return Text(localDate)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .offset(CGSize(width: 0, height: 15))
    }
}

struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView(weathers: WeatherDays.getDefault())
    }
}
