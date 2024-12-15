# Weather Tracker

## Overview
Weather Tracker is a simple weather application built with Swift and SwiftUI that demonstrates clean architecture principles and modern iOS development practices. The app allows users to search for a city, view its current weather, and save the city for quick access in future sessions. The app follows the provided Figma design and integrates weather data from WeatherAPI.com.

## Features
- **Search and View Weather**: Search for cities and display current weather details such as:
  - Temperature
  - Weather condition (with icon)
  - Humidity (%)
  - UV index
  - "Feels like" temperature
- **City Persistence**: The selected city is saved locally and reloaded on app launch.
- **Error Handling**: User-friendly error messages for invalid cities or network issues.
- **Clean Architecture**: Follows MVVM pattern with protocol-oriented programming and dependency injection.
- **Dark Mode Support**: Fully supports both light and dark themes.
- **Testing**: Unit tests for key components to ensure reliability and maintainability.

## Requirements
- **iOS 16.0+**
- **Xcode 15.0+**
- WeatherAPI.com API Key

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/weather-tracker.git
   ```
2. Open the project in Xcode:
   ```bash
   cd weather-tracker
   open Weather_Tracker.xcodeproj
   ```
3. Build and run the app on the simulator or a physical device.

### API Key Information
An API key for WeatherAPI.com is included in the project to simplify the review process. **This key will be revoked after the review is completed** to ensure security. You can replace it with your own API key by modifying the `Requests` enum in `API.swift`:
```swift
let parameters: [String: Encodable] = [
    "key": "your_api_key_here",
    "q": city
]
```

## Evaluation Highlights
- **Architecture**: Clean, modular, and testable MVVM design with clear separation of concerns.
- **API Integration**: Smooth WeatherAPI.com integration with error handling.
- **UI/UX**: Matches provided Figma designs and supports dark mode.
- **Testing**: Includes unit tests to validate key functionalities.

## Notes
- The app meets all the main requirements outlined in the take-home test description.
- Additional features like support for dark mode and robust error handling improve the overall user experience.
- If you have any questions or encounter issues while reviewing, feel free to reach out.
