//
//  Theme.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import Foundation
import SwiftUI

public struct Fonts {
    public static let displayLarge: Font = .custom("Poppins-Medium", size: 70) // temperature in main screen
    public static let displayMedium: Font = .custom("Poppins-Medium", size: 60) // temperature in card
    public static let displaySmall: Font = .custom("Poppins-SemiBold", size: 30) // city name large
    
    public static let headlineLarge: Font = .custom("Poppins-Medium", size: 32)
    public static let headlineMedium: Font = .custom("Poppins-Medium", size: 28)
    public static let headlineSmall: Font = .custom("Poppins-Medium", size: 24)
    
    public static let titleLarge: Font = .custom("Poppins-SemiBold", size: 20) // city name in card
    public static let titleMedium: Font = .custom("Poppins-SemiBold", size: 18)
    public static let titleSmall: Font = .custom("Poppins-SemiBold", size: 14)
    
    public static let bodyLarge: Font = .custom("Poppins-Medium", size: 16)
    public static let bodyMedium: Font = .custom("Poppins-Medium", size: 14)
    public static let bodySmall: Font = .custom("Poppins-Medium", size: 12)
    
    public static let labelLarge: Font = .custom("Poppins-Regular", size: 15) // 20% search
    public static let labelMedium: Font = .custom("Poppins-Medium", size: 12) // humidity uv
    public static let labelSmall: Font = .custom("Poppins-Medium", size: 8) // feels like
}

public extension Fonts {
    class __ {}
    static func registerFonts() {
        guard let semiBoldUrl = Bundle(for: __.self).url(forResource: "Poppins-SemiBold", withExtension: "ttf") else { return }
        guard let mediumUrl = Bundle(for: __.self).url(forResource: "Poppins-Medium", withExtension: "ttf") else { return }
        guard let regularUrl = Bundle(for: __.self).url(forResource: "Poppins-Regular", withExtension: "ttf") else { return }
        CTFontManagerRegisterFontsForURL(semiBoldUrl as CFURL, .process, nil)
        CTFontManagerRegisterFontsForURL(mediumUrl as CFURL, .process, nil)
        CTFontManagerRegisterFontsForURL(regularUrl as CFURL, .process, nil)
    }
}

extension View {
    public func loadFontsForPreviews() -> some View {
        Fonts.registerFonts()
        return self
    }
}
