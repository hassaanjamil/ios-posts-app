import Foundation

@MainActor
final class PostDetailViewModel: ObservableObject {

    @Published private(set) var user: User?
    @Published private(set) var comments: [Comment] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let getUserByIdUseCase: GetUserByIdUseCaseProtocol
    private let getCommentsUseCase: GetCommentsUseCaseProtocol

    init(getUserByIdUseCase: GetUserByIdUseCaseProtocol,
         getCommentsUseCase: GetCommentsUseCaseProtocol) {
        self.getUserByIdUseCase = getUserByIdUseCase
        self.getCommentsUseCase = getCommentsUseCase
    }

    func load(post: Post) async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        async let fetchedUser = getUserByIdUseCase.execute(userId: post.userId)
        async let fetchedComments = getCommentsUseCase.execute(postId: post.id)

        do {
            user = try await fetchedUser
            comments = try await fetchedComments
        } catch {
            errorMessage = error.localizedDescription
            user = nil
            comments = []
        }

        isLoading = false
    }
}
