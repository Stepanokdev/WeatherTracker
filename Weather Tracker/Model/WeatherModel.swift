//
//  WeatherModel.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import Foundation

struct WeatherModel: Hashable {
    let icon: String
    let temperature: Double
    let currentTime: Date
    let uvIndex: Double
    let latitude: Double
    let longtitude: Double
    let timezone: String
    let location: LocationInfo
    let humidity: Double
    let feelslike: Double
}

struct LocationInfo: Hashable {
    let name: String
    let region: String
    let country: String
}

// MARK: - Mock data
extension WeatherModel {
    static var mock: WeatherModel {
        
        return WeatherModel(
            icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png",
            temperature: 25,
            currentTime: Date(),
            uvIndex: 4,
            latitude: 41.88,
            longtitude: -87.62,
            timezone: "Europe/Kiev",
            location: LocationInfo(
                name: "Chicago",
                region: "Illinois",
                country: "United States"
            ),
            humidity: 76,
            feelslike: 31
        )
    }
}
