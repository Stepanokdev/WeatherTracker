//
//  DetailsView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import SwiftUI

struct DetailsView: View {
    
    let humidity: Double
    let uv: Double
    let feelsLike: Double
    
    init(humidity: Double, uv: Double, feelsLike: Double) {
        self.humidity = humidity
        self.uv = uv
        self.feelsLike = feelsLike
    }
    
    var body: some View {
        HStack {
            VerticalStack(title: "Humidity", value: "\(humidity)%")
            Spacer()
            VerticalStack(title: "UV", value: String(uv))
            Spacer()
            VerticalStack(title: "Feels like", value: "\(String(feelsLike)) %")
        }
        .padding(.all, 18)
    }
}

struct VerticalStack: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .foregroundColor(Color(.mediumGray))
                .font(.labelMedium)
            Text(value)
                .foregroundColor(Color(.darkGray))
                .font(.labelLarge)
        }
    }
}

#Preview {
    DetailsView(humidity: 78, uv: 4, feelsLike: 22)
        .loadFonts()
}
