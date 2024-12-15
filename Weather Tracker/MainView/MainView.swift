//
//  MainView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.background)
                .ignoresSafeArea()
            VStack {
                SearchFieldView(text: $viewModel.searchFieldText)
                
                if viewModel.searchFieldText.isEmpty {
                    if let currentWeather = viewModel.currentWeather {
                        InformationView(model: currentWeather)
                            .padding(.top, 74)
                    } else {
                        NoCitySelectedView()
                            .frame(maxHeight: .infinity)
                    }
                } else {
                    if let searchCityWeather = viewModel.searchCityWeather {
                        CityDetailView(weather: searchCityWeather)
                            .onTapGesture {
                                viewModel.updateCurrentCity()
                            }
                            .padding(.top, 32)
                    } else {
                        if viewModel.fetchInProgress{
                            ProgressView().progressViewStyle(.circular)
                                .padding(.top, 32)
                        }
                    }
                }
            }
            .padding(24)
            
            // MARK: - Error Alert
            if viewModel.showError {
                VStack {
                    Spacer()
                    SnackBarView(message: viewModel.errorMessage)
                }
                .transition(.move(edge: .bottom))
                .onAppear {
                    doAfter(TimeInterval(3)) {
                        viewModel.errorMessage = nil
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(
        viewModel: MainViewModel(
            repository: WeatherRepository()
        )
    ).loadFonts()
}
