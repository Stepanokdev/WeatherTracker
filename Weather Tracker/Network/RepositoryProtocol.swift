//
//  RepositoryProtocol.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import Foundation
import MapKit

protocol WeatherRepositoryProtocol {
    func searchCity(name: String) async throws -> [CityModel]
    func getWeather(city: String) async throws -> WeatherModel
}

class WeatherRepository: WeatherRepositoryProtocol {
    func searchCity(name: String) async throws -> [CityModel] {
        do {
            let data = try await API.sendRequestData(request: Requests.autoComplete(city: name))
            
            guard let result = data.convertTo(CityData.self) else {
                throw WeatherError.parsing("Failed to parse city data")
            }
            
            guard !result.domain.isEmpty else {
                throw WeatherError.cityNotFound
            }
            
            return result.domain
        } catch let error as WeatherError {
            throw error
        } catch {
            throw WeatherError.networkError(error.localizedDescription)
        }
    }
    
    func getWeather(city: String) async throws -> WeatherModel {
        do {
            let data = try await API.sendRequestData(request: Requests.getWeather(city: city))
            
            guard let result = data.convertTo(WeatherApiResponse.self) else {
                throw WeatherError.parsing("Failed to parse weather data")
            }
            
            return result.domain
        } catch let error as WeatherError {
            throw error
        } catch {
            throw WeatherError.networkError(error.localizedDescription)
        }
    }
}

class WeatherRepositoryMock: WeatherRepositoryProtocol {
    func searchCity(name: String) async throws -> [CityModel] {
        [
            CityModel(
                city: "Los Angeles",
                state: "California",
                country: "USA",
                longitude: 0,
                latitude: 0
            )
        ]
    }
    
    func getWeather(city: String) async throws -> WeatherModel {
        WeatherModel.mock
    }
}
