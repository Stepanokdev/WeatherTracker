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
    @Published private(set) var currentWeather: WeatherModel?
    
    private var subscription = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?
    private var prevQuery: String = ""
    
    private let repository: WeatherRepositoryProtocol
    private let userDefaults: UserDefaults
    
    private enum UserDefaultsKeys {
        static let lastSelectedCity = "lastSelectedCity"
    }
    
    @Published var showError: Bool = false
    var errorMessage: String? {
        didSet {
            withAnimation {
                showError = errorMessage != nil
            }
        }
    }
    
    init(repository: WeatherRepositoryProtocol, userDefaults: UserDefaults = .standard) {
        self.repository = repository
        self.userDefaults = userDefaults
        
        $searchFieldText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                guard let self = self else { return }
                
                // Cancel any existing search task
                self.searchTask?.cancel()
                
                let term = searchTerm.trimmingCharacters(in: .whitespaces)
                if term.isEmpty {
                    self.searchCityWeather = nil
                    self.prevQuery = ""
                    self.errorMessage = nil
                    return
                }
                
                guard searchTerm.count >= 3 else { return }
                // Create new search task
                self.searchTask = Task {
                    await self.search(term: term)
                }
            }
            .store(in: &subscription)
        
        // Load last selected city on init
        Task {
            await loadLastSelectedCity()
        }
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
            
            // Save selected city to UserDefaults
            userDefaults.set(searchCityWeather.location.name, forKey: UserDefaultsKeys.lastSelectedCity)
        }
    }
    
    private func loadLastSelectedCity() async {
        if let lastCity = userDefaults.string(forKey: UserDefaultsKeys.lastSelectedCity) {
            do {
                let weather = try await getCurrentWeather(for: lastCity)
                self.currentWeather = weather
            } catch {
                self.errorMessage = WeatherError.unknown.localizedDescription
            }
        }
    }
}
