//
//  DetailView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Binding var weather: WeatherData
    @Binding var showDetails: Bool
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                VStack(spacing: 20) {
                    
                    // Day text
                    Text(self.weather.day).fontWeight(.bold)
                        .font(.system(size: 60))
                        .frame(height: gr.size.height * 1/10)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.white)
                        
                    // Weather image
                    Image(systemName: self.weather.weatherIcon)
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: gr.size.height * 3 / 10, height: gr.size.height * 3 / 10)
                        
                    // Degrees texts
                    VStack {
                        VStack(spacing: 20) {
                            Text("\(self.weather.currentTemp)°")
                                .font(.system(size: 50))
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .frame(height: gr.size.height * 0.7/10)
                                    .minimumScaleFactor(0.5)
                                
                            HStack(spacing: 40) {
                                Text("\(self.weather.minTemp)°")
                                    .foregroundColor(Color("light-text"))
                                    .font(.title)
                                    .minimumScaleFactor(0.5)
                                    
                                Text("\(self.weather.maxTemp)°")
                                    .foregroundColor(Color.white)
                                    .font(.title)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: gr.size.height, alignment: .bottom)
                    .background(Color(self.weather.color))
                    .clipShape(CustomShape(), style: FillStyle.init(eoFill: true, antialiased: true))
                
                // Close icon
                HStack {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 20, height: 20)
                }.padding(20)
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
        DetailView(weather: .constant(WeatherData(id: 1, day: "Monday", weatherIcon:  "sun.max", currentTemp:  "40", minTemp: "25", maxTemp: "69", color: "mainCard")), showDetails: .constant(false))
    }
}
