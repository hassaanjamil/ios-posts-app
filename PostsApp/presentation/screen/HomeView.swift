//
//  HomeRootView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUICore
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack { // Or NavigationView
            List {
                ForEach(0..<10) { item in
                    NavigationLink(destination: PostDetailView(item: item)) {
                        Text("Item \(item)")
                    }
                }
            }
            .navigationTitle("Posts")
        }
    }
}
