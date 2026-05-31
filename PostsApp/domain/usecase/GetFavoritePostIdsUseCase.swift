protocol GetFavoritePostIdsUseCaseProtocol {
    func execute() -> Set<Int>
}

final class GetFavoritePostIdsUseCase: GetFavoritePostIdsUseCaseProtocol {
    private let favoritePostRepository: FavoritePostRepositoryProtocol

    init(favoritePostRepository: FavoritePostRepositoryProtocol) {
        self.favoritePostRepository = favoritePostRepository
    }

    func execute() -> Set<Int> {
        favoritePostRepository.getFavoritePostIds()
    }
}
