protocol CommentRepositoryProtocol {
    func getComments(postId: Int) async throws -> [CommentDto]
}
