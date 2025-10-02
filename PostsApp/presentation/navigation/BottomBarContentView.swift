//
//  BottomBarContentView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUICore
import SwiftUI

struct BottomBarContentView: View {
    var body: some View {
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
    }
}
