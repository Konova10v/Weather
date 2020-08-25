//
//  DetailView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Binding var weathers: TempStructure
    @Binding var showDetails: Bool
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                VStack(spacing: 20) {
                    // Day text
                    self.getDate()
                        
                    // Weather image
                    Image(systemName: "sun.max")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: gr.size.height * 3 / 10, height: gr.size.height * 3 / 10)
                        
                    // Degrees texts
                    self.getTemp()
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: gr.size.height, alignment: .bottom)
                .background(Color("mainCard"))
                .clipShape(CustomShape(), style: FillStyle.init(eoFill: true, antialiased: true))
                
                // Close icon
                HStack {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 20, height: 20)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(100)
                .offset(x: 0, y: -gr.size.height / 2)
                .shadow(radius: 20)
                .onTapGesture {
                    withAnimation(.spring()) {
                        self.showDetails.toggle()
                    }
                }
            }
        }
    }
    
    func getDate() -> some View {
        var localDate: String = ""
        let timeResult = Double(weathers.dt)
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        localDate = dateFormatter.string(from: date)
        
        return Text(localDate).fontWeight(.bold)
            .font(.system(size: 60))
            .minimumScaleFactor(0.5)
            .foregroundColor(Color.white)
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
        
        return VStack {
            VStack(spacing: 20) {
                Text(temperature + "°")
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.5)
                    
                HStack(spacing: 40) {
                    Text(temperatureMin + "°")
                        .foregroundColor(Color("light-text"))
                        .font(.title)
                        .minimumScaleFactor(0.5)
                        
                    Text(temperatureMax + "°")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .minimumScaleFactor(0.5)
                }
            }
        }
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 40
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), control: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: cornerRadius), control: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weathers: .constant(TempStructure(dt: 20, temp: Temp(day: 0, min: 0, max: 0), humidity: 12)), showDetails: .constant(false))
    }
}
