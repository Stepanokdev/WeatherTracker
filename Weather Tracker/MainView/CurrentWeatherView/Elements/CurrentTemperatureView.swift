//
//  CurrentTemperatureView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import SwiftUI
import Kingfisher

struct CurrentTemperatureView: View {
    
    let title: String
    let icon: String
    let temperature: Int
    
    init(title: String, icon: String, temperature: Double) {
        self.title = title
        self.icon = icon
        self.temperature = Int(temperature)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let url = URL(string: icon) {
                KFImage(url)
            }
            HStack(spacing: 8) {
                Text(title)
                    .font(.displaySmall)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                Image(.geo)
            }
            HStack(alignment: .top) {
                Text("\(temperature)")
                    .font(.displayLarge)
                    .fontWeight(.semibold)
                Text("°")
                    .font(.headlineMedium)
            }
            .padding(.top, 15)
        }
        .padding(.horizontal, 48)
        
    }
}

#Preview {
    ScrollView {
        CurrentTemperatureView(
            title: "Azpilicuetagaraycosaroyarenberecolarrea", // long name test
            icon: "",
            temperature: 37
        )
        CurrentTemperatureView(
            title: "Chicago",
            icon: "",
            temperature: 42
        )
        CurrentTemperatureView(
            title: "New York",
            icon: "",
            temperature: 12
        )
    }
    .loadFonts()
}
