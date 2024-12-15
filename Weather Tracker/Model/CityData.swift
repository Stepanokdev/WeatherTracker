//
//  CityData.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


//
//  CityData.swift
//  Weather Tracker
//

import Foundation

// MARK: - CityData
struct CityData: Codable {
    let cities: [City]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        cities = try container.decode([City].self)
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}

// MARK: - Data Mapping
extension CityData {
    var domain: [CityModel] {
        cities.map { city in
            CityModel(
                city: city.name,
                state: city.region,
                country: city.country,
                longitude: city.lon,
                latitude: city.lat
            )
        }
    }
}
