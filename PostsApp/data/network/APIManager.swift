//
//  APIManager.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import Alamofire

class APIManager {
    static let shared = APIManager() // Singleton instance
    private let BASE_URL = "https://127.0.0.1:3000"

    private init() {} // Prevent external instantiation

    func getPosts() async throws -> [SPost] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(BASE_URL)/posts") // Replace with your actual API endpoint
                .validate()
                .responseDecodable(of: [SPost].self) { response in
                    switch response.result {
                    case .success(let posts):
                        continuation.resume(returning: posts)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
