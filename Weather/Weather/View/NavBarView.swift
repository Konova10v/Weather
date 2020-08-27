//
//  NavBarView.swift
//  Weather
//
//  Created by Кирилл Коновалов on 22.08.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import SwiftUI

struct NavBarView: View {
// MARK: - Parametrs
    var country = "Russia"
    @Binding var showSearch: Bool
    
// MARK: - UI
    var body: some View {
        HStack {
            Text(country).font(.title)
            Spacer()
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 25, height: 25)
                .sheet(isPresented: self.$showSearch, content: {
                    SearchView(searchWeatherVM: CurrentWeatherViewModel())
            })
            .cornerRadius(CGFloat(20))
            .padding()
        }.padding()
            .onTapGesture {
                self.showSearch.toggle()
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(showSearch: .constant(false))
    }
}
