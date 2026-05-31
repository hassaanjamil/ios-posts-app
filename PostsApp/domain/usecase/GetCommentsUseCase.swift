protocol GetCommentsUseCaseProtocol {
    func execute(postId: Int) async throws -> [Comment]
}

final class GetCommentsUseCase: GetCommentsUseCaseProtocol {
    private let commentRepository: CommentRepositoryProtocol

    init(commentRepository: CommentRepositoryProtocol) {
        self.commentRepository = commentRepository
    }

    func execute(postId: Int) async throws -> [Comment] {
        let commentDtos = try await commentRepository.getComments(postId: postId)
        return commentDtos.map { dto in
            Comment(id: dto.id, body: dto.body, postId: dto.postId, userId: dto.userId)
        }
    }
}
