//
//  AppContainer+Environment.swift
//  PostsApp
//
//  Created by Hassan Jamil on 05/10/2025.
//

import SwiftUI

private struct AppContainerKey: EnvironmentKey {
    static let defaultValue: AppContainer = .shared
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
