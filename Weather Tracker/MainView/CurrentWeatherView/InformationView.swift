//
//  InformationView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import SwiftUI
import CoreLocation

struct InformationView: View {
    
    let model: WeatherModel
    
    init(model: WeatherModel) {
        self.model = model
    }
    
    var body: some View {
        
        VStack {
                CurrentTemperatureView(
                    title: model.location.name,
                    icon: model.icon,
                    temperature: model.temperature
                )
                DetailsView(
                    humidity: model.humidity,
                    uv: model.uvIndex,
                    feelsLike: model.feelslike
                )
                .roundedBackground(16)
                .padding(.horizontal, 46)
        }
    }
}

#Preview {
    InformationView(model: WeatherModel.mock)
        .loadFonts()
}
