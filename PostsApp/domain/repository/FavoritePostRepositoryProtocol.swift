protocol FavoritePostRepositoryProtocol {
    func getFavoritePostIds() -> Set<Int>
    func setFavorite(postId: Int, isFavorite: Bool)
}
