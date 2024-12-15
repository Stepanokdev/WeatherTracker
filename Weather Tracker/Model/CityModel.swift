//
//  CityModel.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import Foundation

// MARK: - Domain Model
struct CityModel: Hashable {
    let city: String
    let state: String
    let country: String
    let longitude: Double
    let latitude: Double
}
