//
//  AppContainer.swift
//  PostsApp
//
//  Created by Hassan Jamil on 05/10/2025.
//

import Swinject

@MainActor
final class AppContainer {

    static let shared = AppContainer()

    let container: Container

    private init(container: Container = Container()) {
        self.container = container
        registerDependencies()
    }

    // MARK: - Public

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container.resolve(serviceType) else {
            fatalError("Failed to resolve \(serviceType)")
        }
        return service
    }

    // MARK: - Private

    private func registerDependencies() {
        registerNetwork()
        registerLocalStores()
        registerRepositories()
        registerUseCases()
        registerMapper()
        registerViewModels()
    }

    private func registerNetwork() {
        container.register(NetworkManagerProtocol.self) { _ in
            NetworkManager()
        }
        .inObjectScope(.container)
    }

    private func registerLocalStores() {
        container.register(FavoriteStoreProtocol.self) { _ in
            FavoriteStore()
        }
        .inObjectScope(.container)
    }

    private func registerRepositories() {
        container.register(PostRepositoryProtocol.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManagerProtocol.self) else {
                fatalError("NetworkManagerProtocol dependency has not been registered")
            }
            return PostRepository(networkManager: networkManager)
        }
        .inObjectScope(.container)

        container.register(UserRepositoryProtocol.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManagerProtocol.self) else {
                fatalError("NetworkManagerProtocol dependency has not been registered")
            }
            return UserRepository(networkManager: networkManager)
        }
        .inObjectScope(.container)

        container.register(CommentRepositoryProtocol.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManagerProtocol.self) else {
                fatalError("NetworkManagerProtocol dependency has not been registered")
            }
            return CommentRepository(networkManager: networkManager)
        }
        .inObjectScope(.container)

        container.register(FavoritePostRepositoryProtocol.self) { resolver in
            guard let favoriteStore = resolver.resolve(FavoriteStoreProtocol.self) else {
                fatalError("FavoriteStoreProtocol dependency has not been registered")
            }
            return FavoritePostRepository(favoriteStore: favoriteStore)
        }
        .inObjectScope(.container)
    }

    private func registerUseCases() {
        container.register(GetPostsUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(PostRepositoryProtocol.self) else {
                fatalError("PostRepositoryProtocol dependency has not been registered")
            }
            return GetPostsUseCase(postRepository: repository)
        }

        container.register(GetUserByIdUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(UserRepositoryProtocol.self) else {
                fatalError("UserRepositoryProtocol dependency has not been registered")
            }
            return GetUserByIdUseCase(userRepository: repository)
        }

        container.register(GetCommentsUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(CommentRepositoryProtocol.self) else {
                fatalError("CommentRepositoryProtocol dependency has not been registered")
            }
            return GetCommentsUseCase(commentRepository: repository)
        }

        container.register(GetFavoritePostIdsUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(FavoritePostRepositoryProtocol.self) else {
                fatalError("FavoritePostRepositoryProtocol dependency has not been registered")
            }
            return GetFavoritePostIdsUseCase(favoritePostRepository: repository)
        }

        container.register(ToggleFavoritePostUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(FavoritePostRepositoryProtocol.self) else {
                fatalError("FavoritePostRepositoryProtocol dependency has not been registered")
            }
            return ToggleFavoritePostUseCase(favoritePostRepository: repository)
        }
    }

    private func registerMapper() {
        container.register(PostMapperProtocol.self) { _ in
            PostMapper()
        }
        .inObjectScope(.container)
    }

    private func registerViewModels() {
        container.register(HomeViewModel.self) { resolver in
            guard let getPostsUseCase = resolver.resolve(GetPostsUseCaseProtocol.self) else {
                fatalError("GetPostsUseCaseProtocol dependency has not been registered")
            }

            guard let getFavoritePostIdsUseCase = resolver.resolve(GetFavoritePostIdsUseCaseProtocol.self) else {
                fatalError("GetFavoritePostIdsUseCaseProtocol dependency has not been registered")
            }

            guard let toggleFavoritePostUseCase = resolver.resolve(ToggleFavoritePostUseCaseProtocol.self) else {
                fatalError("ToggleFavoritePostUseCaseProtocol dependency has not been registered")
            }

            guard let postMapper = resolver.resolve(PostMapperProtocol.self) else {
                fatalError("PostMapperProtocol dependency has not been registered")
            }

            return HomeViewModel(getPostsUseCase: getPostsUseCase,
                                 getFavoritePostIdsUseCase: getFavoritePostIdsUseCase,
                                 toggleFavoritePostUseCase: toggleFavoritePostUseCase,
                                 postMapper: postMapper)
        }

        container.register(PostDetailViewModel.self) { resolver in
            guard let getUserByIdUseCase = resolver.resolve(GetUserByIdUseCaseProtocol.self) else {
                fatalError("GetUserByIdUseCaseProtocol dependency has not been registered")
            }

            guard let getCommentsUseCase = resolver.resolve(GetCommentsUseCaseProtocol.self) else {
                fatalError("GetCommentsUseCaseProtocol dependency has not been registered")
            }

            return PostDetailViewModel(getUserByIdUseCase: getUserByIdUseCase,
                                       getCommentsUseCase: getCommentsUseCase)
        }
    }
}
