//
//  SnackBarView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI

public struct SnackBarView: View {
    
    var message: String
    
    private let minHeight: CGFloat = 50
    
    public init(message: String?) {
        self.message = message ?? ""
    }
    
    public var body: some View {
        HStack {
            Text(message)
                .font(.titleSmall)
                .foregroundStyle(.white)
                .padding(24)
            Spacer()
        }.roundedBackground(bgColor: Color(.red))
            .padding(16)
    }
}

#Preview {
    SnackBarView(message: "Text message")
        .loadFonts()
}
