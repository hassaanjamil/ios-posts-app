protocol GetUserByIdUseCaseProtocol {
    func execute(userId: Int) async throws -> User
}

final class GetUserByIdUseCase: GetUserByIdUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute(userId: Int) async throws -> User {
        let userDto = try await userRepository.getUserById(userId)
        return User(id: userDto.id, name: userDto.name, username: userDto.username)
    }
}
