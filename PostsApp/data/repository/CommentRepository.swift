final class CommentRepository: CommentRepositoryProtocol {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getComments(postId: Int) async throws -> [CommentDto] {
        try await networkManager.getComments(postId: postId)
    }
}
