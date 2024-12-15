//
//  ViewExtensions.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI

extension View {
    
    func roundedBackground(
        _ cornerRadius: CGFloat = 11,
        bgColor: Color = Color(.lightGray)
    ) -> some View {
        return self.background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(bgColor)
        }
    }
    
    public func loadFonts() -> some View {
        Font.registerFonts()
        return self
    }
}

public func doAfter(_ delay: TimeInterval? = nil, _ closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 0), execute: closure)
}
