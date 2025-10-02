//
//  AuthView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUICore
import SwiftUI

struct AuthView: View {
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        VStack {
            Text("Login / Signup")
            Button("Authenticate") {
                // Perform authentication logic
                isAuthenticated = true
            }
        }
    }
}
