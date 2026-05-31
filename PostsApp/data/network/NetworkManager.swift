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

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL configuration."
        case .invalidResponse:
            return "Server returned an invalid response. Please try again."
        case .decodingFailed:
            return "Failed to decode server data. Check backend response format."
        }
    }
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
        return try await request(url: url, responseType: [PostDto].self)
    }

    func getUserById(_ userId: Int) async throws -> UserDto {
        let url = baseURL
            .appendingPathComponent("users")
            .appendingPathComponent(String(userId))
        return try await request(url: url, responseType: UserDto.self)
    }

    func getComments(postId: Int) async throws -> [CommentDto] {
        let url = baseURL
            .appendingPathComponent("comments")
            .appendingPathComponent(String(postId))
        return try await request(url: url, responseType: [CommentDto].self)
    }

    private func request<T: Decodable>(url: URL,
                                       responseType: T.Type) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(responseType, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
