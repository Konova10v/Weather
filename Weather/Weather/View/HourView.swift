//
//  HourView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct HourView: View {
    var hour = "14:00"
    var icon = "sun.max.fill"
    var color = "wednesday"
    
    var body: some View {
        GeometryReader { gr in
            VStack {
                Text(self.hour)
                    .foregroundColor(Color("text"))
                Image(systemName: self.icon)
                    .resizable()
                    .foregroundColor(Color(self.color))
                    .frame(width: gr.size.height * 1/4, height: gr.size.height * 1/4)
                
                Text("24°")
                    .font(.system(size: 24))
                    .foregroundColor(Color("text"))
                    .fontWeight(.semibold)
            }
        }.padding(.vertical, 30)
    }
}

struct HourView_Previews: PreviewProvider {
    static var previews: some View {
        HourView()
    }
}
