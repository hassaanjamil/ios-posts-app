final class UserRepository: UserRepositoryProtocol {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getUserById(_ userId: Int) async throws -> UserDto {
        try await networkManager.getUserById(userId)
    }
}
