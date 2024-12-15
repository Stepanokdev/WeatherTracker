//
//  CityDetailView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI
import MapKit
import Kingfisher

struct CityDetailView: View {
    
    var weather: WeatherModel
            
    init(weather: WeatherModel) {
        self.weather = weather
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(weather.location.name)
                            .font(Fonts.titleLarge)
                            .multilineTextAlignment(.center)
                            .frame(alignment: .center)
                            .padding(.top, 7)
                        HStack(alignment: .top, spacing: 0) {
                            Text(String(Int(weather.temperature)))
                                .font(Fonts.displayMedium)
                            Text("°")
                                .font(.system(size: 20))
                                .offset(y: 10)
                        }
                    }
                    
                    if let url = URL(string: weather.icon) {
                        KFImage(url)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.horizontal, 31)
                .frame(height: 117)
                .frame(maxWidth: .infinity)
                .roundedBackground()
            }
        }
    }
}

#Preview {
    CityDetailView(weather: .mock)
        .loadFontsForPreviews()
}
