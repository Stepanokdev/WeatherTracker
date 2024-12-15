//
//  Weather_TrackerApp.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI

@main
struct Weather_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(repository: WeatherRepository()))
        }
    }
}
