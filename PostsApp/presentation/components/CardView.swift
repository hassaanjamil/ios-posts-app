//
//  CardView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUICore

struct CardView<Content: View>: View {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let padding: CGFloat
    let content: Content
    
    init(cornerRadius: CGFloat = 16,
         shadowRadius: CGFloat = 2,
         padding: CGFloat = 12,
         @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color(uiColor: .secondarySystemBackground)) // ✅ card-like background
                    .shadow(color: Color.black.opacity(0.1),
                            radius: shadowRadius,
                            x: 0, y: 1)
            )
    }
}
