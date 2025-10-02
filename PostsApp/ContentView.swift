//
//  ContentView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
    
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false

    var body: some View {
        if isAuthenticated {
            BottomBarContentView()
        } else {
            AuthView(isAuthenticated: $isAuthenticated)
        }
    }
}

#Preview {
    ContentView()
}
