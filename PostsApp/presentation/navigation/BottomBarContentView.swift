//
//  BottomBarContentView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

@MainActor
struct BottomBarContentView: View {
    @Environment(\.appContainer) private var appContainer
    @StateObject private var homeViewModel: HomeViewModel

    init() {
        _homeViewModel = StateObject(wrappedValue: AppContainer.shared.resolve(HomeViewModel.self))
    }

    var body: some View {
        TabView {
            HomeView(viewModel: homeViewModel,
                     container: appContainer)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            FavoriteView(viewModel: homeViewModel,
                         container: appContainer)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }

            NavigationStack {
                SettingsView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.fill")
                                    .font(.title2)
                            }
                        }
                    }
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
        .task {
            if homeViewModel.posts.isEmpty {
                await homeViewModel.loadPosts()
            }
        }
    }
}
