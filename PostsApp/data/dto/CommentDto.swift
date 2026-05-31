import Foundation

struct CommentDto: Codable, Identifiable {
    let id: Int
    let body: String
    let postId: Int
    let userId: Int
}
