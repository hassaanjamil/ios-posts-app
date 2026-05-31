import Foundation

struct UserDto: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
}
