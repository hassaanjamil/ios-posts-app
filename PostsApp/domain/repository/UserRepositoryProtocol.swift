protocol UserRepositoryProtocol {
    func getUserById(_ userId: Int) async throws -> UserDto
}
