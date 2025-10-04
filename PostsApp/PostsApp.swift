//
//  PostsAppApp.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

@main
struct PostsApp: App {
    private let appContainer = AppContainer.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appContainer, appContainer)
        }
    }
}
