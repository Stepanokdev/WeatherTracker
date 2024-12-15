//
//  SearchFieldView.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import SwiftUI

struct SearchFieldView: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(
                "searchScreen",
                text: $text,
                prompt: (Text("Search location")
                    .foregroundColor(Color(.mediumGray)))
            )
            .font(Fonts.labelLarge)
            .padding(.leading, 15)
            Spacer()
            Image(.search)
                .padding(.trailing, 15)
        }
        .frame(height: 44)
        .roundedBackground(15)
        
    }
}

#Preview {
    @Previewable @State var text = ""
    return SearchFieldView(text: $text)
        .loadFontsForPreviews()
}
