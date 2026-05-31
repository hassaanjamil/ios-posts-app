final class FavoritePostRepository: FavoritePostRepositoryProtocol {

    private let favoriteStore: FavoriteStoreProtocol

    init(favoriteStore: FavoriteStoreProtocol) {
        self.favoriteStore = favoriteStore
    }

    func getFavoritePostIds() -> Set<Int> {
        favoriteStore.getFavoritePostIds()
    }

    func setFavorite(postId: Int, isFavorite: Bool) {
        favoriteStore.setFavorite(postId: postId, isFavorite: isFavorite)
    }
}
