//
//  APIManager.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
}

final class NetworkManager: NetworkManagerProtocol {

    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL = URL(string: "http://127.0.0.1:3000")!,
         session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func getPosts() async throws -> [PostDto] {
        let url = baseURL.appendingPathComponent("posts")

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        do {
            return try JSONDecoder().decode([PostDto].self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
