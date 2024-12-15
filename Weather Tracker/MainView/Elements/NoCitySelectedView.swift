//
//  NoCitySelectedView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI

struct NoCitySelectedView: View {
    var body: some View {
        VStack {
            Text("No City Selected")
                .font(Fonts.displaySmall)
            Text("Please Search For A City")
                .font(Fonts.labelLarge)
        }
    }
}

#Preview {
    NoCitySelectedView()
        .loadFontsForPreviews()
}
