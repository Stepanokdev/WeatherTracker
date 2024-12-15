//
//  WeatherError.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import Foundation

enum WeatherError: LocalizedError {
    case parsing(String)
    case networkError(String)
    case cityNotFound
    case emptyResponse
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .parsing(let details):
            return "Failed to parse data: \(details)"
        case .networkError(let details):
            return "Network error: \(details)"
        case .cityNotFound:
            return "City not found"
        case .emptyResponse:
            return "Empty response from server"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}
