//
//  BottomBarContentView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct BottomBarContentView: View {
    @Environment(\.appContainer) private var appContainer

    var body: some View {
        NavigationStack {
            TabView {
                HomeView(container: appContainer)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                FavoriteView()
                    .tabItem {
                        Label("Profile", systemImage: "heart.fill")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.fill")
                            .font(.title2)
                    }
                }
            }
        }
    }
}
