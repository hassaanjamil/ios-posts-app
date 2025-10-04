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

    private func registerRepositories() {
        container.register(PostRepositoryProtocol.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManagerProtocol.self) else {
                fatalError("NetworkManagerProtocol dependency has not been registered")
            }
            return PostRepository(networkManager: networkManager)
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

            guard let postMapper = resolver.resolve(PostMapperProtocol.self) else {
                fatalError("PostMapperProtocol dependency has not been registered")
            }

            return HomeViewModel(getPostsUseCase: getPostsUseCase,
                                 postMapper: postMapper)
        }
    }
}
