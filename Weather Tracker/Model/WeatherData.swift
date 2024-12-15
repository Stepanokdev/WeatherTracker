//
//  WeatherData.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import Foundation

// MARK: - WeatherApiResponse
struct WeatherApiResponse: Codable {
    let location: Location
    let current: Current
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat, lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let precipMm: Double
    let humidity, cloud: Int
    let uv: Double
    let feelslike: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case precipMm = "precip_mm"
        case humidity, cloud, uv
        case feelslike = "feelslike_c"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

extension WeatherApiResponse {
    var domain: WeatherModel {
        return WeatherModel(
            icon: "https:" + current.condition.icon,
            temperature: current.tempC,
            currentTime: Date(timeIntervalSince1970: TimeInterval(current.lastUpdatedEpoch)),
            uvIndex: current.uv,
            latitude: location.lat,
            longtitude: location.lon,
            timezone: location.tzId,
            location: LocationInfo(
                name: location.name,
                region: location.region,
                country: location.country
            ),
            humidity: 78,
            feelslike: current.feelslike
        )
    }
}
