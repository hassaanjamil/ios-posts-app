protocol ToggleFavoritePostUseCaseProtocol {
    func execute(postId: Int, isFavorite: Bool)
}

final class ToggleFavoritePostUseCase: ToggleFavoritePostUseCaseProtocol {
    private let favoritePostRepository: FavoritePostRepositoryProtocol

    init(favoritePostRepository: FavoritePostRepositoryProtocol) {
        self.favoritePostRepository = favoritePostRepository
    }

    func execute(postId: Int, isFavorite: Bool) {
        favoritePostRepository.setFavorite(postId: postId, isFavorite: isFavorite)
    }
}
