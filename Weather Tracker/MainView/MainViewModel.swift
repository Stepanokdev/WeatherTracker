//
//  MainViewModel.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI
import Combine

@MainActor
class MainViewModel: ObservableObject {
    @Published var searchFieldText: String = ""
    @Published private(set) var searchCityWeather: WeatherModel?
    @Published private(set) var fetchInProgress = false
    private var subscription = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?
    private var prevQuery: String = ""
    private(set) var currentWeather: WeatherModel?
    
    private let repository: WeatherRepositoryProtocol
    
    @Published var showError: Bool = false
    var errorMessage: String? {
        didSet {
            withAnimation {
                showError = errorMessage != nil
            }
        }
    }
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
        
        $searchFieldText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                guard let self = self, searchTerm.count >= 3 else { return }
                
                // Cancel any existing search task
                self.searchTask?.cancel()
                
                let term = searchTerm.trimmingCharacters(in: .whitespaces)
                if term.isEmpty {
                    self.searchCityWeather = nil
                    self.prevQuery = ""
                    self.errorMessage = nil
                    return
                }
                
                // Create new search task
                self.searchTask = Task {
                    await self.search(term: term)
                }
            }
            .store(in: &subscription)
    }
    
    private func search(term: String) async {
        guard term != prevQuery else { return }
        fetchInProgress = true
        do {
            let cities = try await repository.searchCity(name: term)
            guard let citySearchResults = cities.first else {
                self.searchCityWeather = nil
                self.errorMessage = WeatherError.cityNotFound.localizedDescription
                fetchInProgress = false
                return
            }
            
            let weather = try await getCurrentWeather(for: citySearchResults.city)
            self.searchCityWeather = weather
            self.prevQuery = term
            self.errorMessage = nil
            fetchInProgress = false
        } catch let error as WeatherError {
            self.searchCityWeather = nil
            fetchInProgress = false
            switch error {
            case .cityNotFound:
                if term.count >= 5 {
                    self.errorMessage = error.localizedDescription
                }
            default:
                self.errorMessage = error.localizedDescription
            }
        } catch {
            self.searchCityWeather = nil
            self.errorMessage = WeatherError.unknown.localizedDescription
            fetchInProgress = false
        }
    }
    
    func getCurrentWeather(for city: String) async throws -> WeatherModel {
        return try await repository.getWeather(city: city)
    }
    
    func updateCurrentCity() {
        if let searchCityWeather {
            self.currentWeather = searchCityWeather
            self.searchFieldText = ""
            self.errorMessage = nil
        }
    }
}
