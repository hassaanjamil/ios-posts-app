import Foundation

protocol FavoriteStoreProtocol {
    func getFavoritePostIds() -> Set<Int>
    func setFavorite(postId: Int, isFavorite: Bool)
}

final class FavoriteStore: FavoriteStoreProtocol {

    private let defaults: UserDefaults
    private let key: String

    init(defaults: UserDefaults = .standard,
         key: String = "favorite_post_ids") {
        self.defaults = defaults
        self.key = key
    }

    func getFavoritePostIds() -> Set<Int> {
        let values = defaults.array(forKey: key) as? [Int] ?? []
        return Set(values)
    }

    func setFavorite(postId: Int, isFavorite: Bool) {
        var ids = getFavoritePostIds()

        if isFavorite {
            ids.insert(postId)
        } else {
            ids.remove(postId)
        }

        defaults.set(Array(ids).sorted(), forKey: key)
    }
}
