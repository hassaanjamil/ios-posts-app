//
//  BottomBarContentView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct BottomBarContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeRootView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                FavoriteView()
                    .tabItem {
                        Label("Profile", systemImage: "heart")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .navigationTitle("Home") // Navigation title
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
