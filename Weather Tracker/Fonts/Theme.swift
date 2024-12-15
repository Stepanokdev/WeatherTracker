//
//  Theme.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import Foundation
import SwiftUI

extension Font {
    static let displayLarge: Font = .custom("Poppins-Medium", size: 70)
    static let displayMedium: Font = .custom("Poppins-Medium", size: 60)
    static let displaySmall: Font = .custom("Poppins-SemiBold", size: 30)
    
    static let headlineLarge: Font = .custom("Poppins-Medium", size: 32)
    static let headlineMedium: Font = .custom("Poppins-Medium", size: 28)
    static let headlineSmall: Font = .custom("Poppins-Medium", size: 24)
    
    static let titleLarge: Font = .custom("Poppins-SemiBold", size: 20)
    static let titleMedium: Font = .custom("Poppins-SemiBold", size: 18)
    static let titleSmall: Font = .custom("Poppins-SemiBold", size: 14)
    
    static let bodyLarge: Font = .custom("Poppins-Medium", size: 16)
    static let bodyMedium: Font = .custom("Poppins-Medium", size: 14)
    static let bodySmall: Font = .custom("Poppins-Medium", size: 12)
    
    static let labelLarge: Font = .custom("Poppins-Regular", size: 15)
    static let labelMedium: Font = .custom("Poppins-Medium", size: 12)
    static let labelSmall: Font = .custom("Poppins-Medium", size: 8)
}

extension Font {
    class __ {}
    static func registerFonts() {
        guard let semiBoldUrl = Bundle(
            for: __.self
        ).url(
            forResource: "Poppins-SemiBold",
            withExtension: "ttf"
        ) else {
            return
        }
        guard let mediumUrl = Bundle(
            for: __.self
        ).url(
            forResource: "Poppins-Medium",
            withExtension: "ttf"
        ) else {
            return
        }
        guard let regularUrl = Bundle(
            for: __.self
        ).url(
            forResource: "Poppins-Regular",
            withExtension: "ttf"
        ) else {
            return
        }
        CTFontManagerRegisterFontsForURL(semiBoldUrl as CFURL, .process, nil)
        CTFontManagerRegisterFontsForURL(mediumUrl as CFURL, .process, nil)
        CTFontManagerRegisterFontsForURL(regularUrl as CFURL, .process, nil)
    }
}
