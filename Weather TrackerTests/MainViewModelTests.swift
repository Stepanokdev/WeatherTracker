//
//  MainViewModelTests.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import XCTest
@testable import Weather_Tracker

@MainActor
final class MainViewModelTests: XCTestCase {
    
    func testSuccessfulSearchUpdatesWeather() async throws {
        let viewModel = MainViewModel(repository: WeatherRepositoryMock())
        
        XCTAssertNil(viewModel.searchCityWeather)
        XCTAssertFalse(viewModel.fetchInProgress)
        XCTAssertNil(viewModel.errorMessage)
        
        viewModel.searchFieldText = "Los"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertFalse(viewModel.fetchInProgress)
        XCTAssertNotNil(viewModel.searchCityWeather)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testUpdateCurrentCity() async throws {
        let viewModel = MainViewModel(repository: WeatherRepositoryMock())
        
        viewModel.searchFieldText = "Los"
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertNotNil(viewModel.searchCityWeather)
        XCTAssertNil(viewModel.currentWeather)
        
        viewModel.updateCurrentCity()
        
        XCTAssertNotNil(viewModel.currentWeather)
        XCTAssertEqual(viewModel.currentWeather, viewModel.searchCityWeather)
        XCTAssertEqual(viewModel.searchFieldText, "")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testCityNotFoundError() async throws {
        class ErrorMockRepository: WeatherRepositoryProtocol {
            func searchCity(name: String) async throws -> [CityModel] {
                return []
            }
            func getWeather(city: String) async throws -> WeatherModel {
                throw WeatherError.cityNotFound
            }
        }
        
        let viewModel = MainViewModel(repository: ErrorMockRepository())
        
        viewModel.searchFieldText = "ABC"
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertNil(viewModel.searchCityWeather)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, WeatherError.cityNotFound.localizedDescription)
    }
    
    func testNetworkError() async throws {
        class NetworkErrorMockRepo: WeatherRepositoryProtocol {
            func searchCity(name: String) async throws -> [CityModel] {
                throw WeatherError.networkError("No connection")
            }
            func getWeather(city: String) async throws -> WeatherModel {
                fatalError("Should not be called")
            }
        }

        let viewModel = MainViewModel(repository: NetworkErrorMockRepo())

        viewModel.searchFieldText = "Chicago"
        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertNil(viewModel.searchCityWeather)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("No connection") ?? false)
    }
    
    func testParsingError() async throws {
        class ParsingErrorMockRepo: WeatherRepositoryProtocol {
            func searchCity(name: String) async throws -> [CityModel] {
                return [CityModel(city: "TestCity", state: "", country: "", longitude: 0, latitude: 0)]
            }
            func getWeather(city: String) async throws -> WeatherModel {
                throw WeatherError.parsing("Invalid JSON")
            }
        }

        let viewModel = MainViewModel(repository: ParsingErrorMockRepo())
        
        viewModel.searchFieldText = "TestCity"
        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertNil(viewModel.searchCityWeather)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("Invalid JSON") ?? false)
    }
    
    func testUnknownError() async throws {
        class UnknownErrorMockRepo: WeatherRepositoryProtocol {
            func searchCity(name: String) async throws -> [CityModel] {
                return [CityModel(city: "UnknownCity", state: "", country: "", longitude: 0, latitude: 0)]
            }
            func getWeather(city: String) async throws -> WeatherModel {
                throw WeatherError.unknown
            }
        }

        let viewModel = MainViewModel(repository: UnknownErrorMockRepo())
        
        viewModel.searchFieldText = "UnknownCity"
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertNil(viewModel.searchCityWeather)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, WeatherError.unknown.localizedDescription)
    }
    
    func testNoDuplicateRequestForSameQuery() async throws {
        class TestRepo: WeatherRepositoryProtocol {
            var searchCallCount = 0
            func searchCity(name: String) async throws -> [CityModel] {
                searchCallCount += 1
                return [CityModel(city: "RepeatedCity", state: "", country: "", longitude: 0, latitude: 0)]
            }
            func getWeather(city: String) async throws -> WeatherModel {
                return WeatherModel.mock
            }
        }

        let repo = TestRepo()
        let viewModel = MainViewModel(repository: repo)

        viewModel.searchFieldText = "RepeatedCity"
        try? await Task.sleep(nanoseconds: 500_000_000)
        XCTAssertEqual(repo.searchCallCount, 1)

        viewModel.searchFieldText = "RepeatedCity"
        try? await Task.sleep(nanoseconds: 500_000_000)
        XCTAssertEqual(repo.searchCallCount, 1)
    }
}
