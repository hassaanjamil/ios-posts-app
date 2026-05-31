# Sample iOS Posts App

An open-source iOS SwiftUI sample that demonstrates a modern posts feed backed by a REST API using layered Clean Architecture. The project showcases the native iOS APIs for UI, networking, local persistence, and dependency injection.

> For this app, please have a look at my open source [Posts Rest API repository](https://github.com/hassaanjamil/node-posts-rest-api).
Configure it by following the instructions and run the local server so this app works correctly (default port: `3000`).

## Table of Contents
- [Highlights](#highlights)
- [Architecture Overview](#architecture-overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Local API Notes](#local-api-notes)
- [Roadmap Ideas](#roadmap-ideas)
- [Contributing](#contributing)

## Highlights
- 100% Swift with SwiftUI navigation and a tab-based shell (`Home`, `Favorites`, `Settings`).
- Clean layers (`data`, `domain`, `presentation`) with protocol-driven boundaries.
- Dependency injection with Swinject through a single `AppContainer` root.
- Async networking with `URLSession` and Swift concurrency (`async`/`await`).
- Post detail resolves author and comments using dedicated use cases.
- Favorites persist locally using `UserDefaults` and sync across tabs.
- Pull-to-refresh and reusable error/empty state components.

## Architecture Overview
```
PostsApp (SwiftUI App)
        |
        +- data/di AppContainer (Swinject registrations)
        |   +- NetworkManager (URLSession)
        |   +- Repositories (Post, User, Comment, Favorite)
        |   +- Local store (FavoriteStore)
        |
        +- domain (entities + repository contracts + use cases)
        |
        +- presentation (screens + components + view models)
            +- HomeViewModel
            +- PostDetailViewModel
            +- SwiftUI screens (Home/Favorites/PostDetail/Profile/Settings)
```

- State Management: `ObservableObject` view models publish screen state (`posts`, loading/error flags, author/comments details).
- Navigation: `NavigationStack` inside each tab and detail navigation from post cards.
- Feature parity with Android: posts list, favorite toggles, persisted favorites, post detail author fetch, and comments rendering.

## Tech Stack
- Swift 5.9+
- SwiftUI
- URLSession
- Swift Concurrency
- Swinject
- UserDefaults (favorite persistence)
- Xcode 16+ tooling

## Project Structure
```
PostsApp/
 |- data/
 |  |- di/                 # AppContainer registrations
 |  |- dto/                # API DTOs (PostDto, UserDto, CommentDto)
 |  |- local/              # Local storage adapters (FavoriteStore)
 |  |- mapper/             # DTO <-> domain mappers
 |  |- network/            # NetworkManager + protocol
 |  |- protocol/           # Mapper/network protocols
 |  |- repository/         # Repository implementations
 |
 |- domain/
 |  |- entity/             # Post, User, Comment
 |  |- repository/         # Repository contracts
 |  |- usecase/            # GetPosts, GetUserById, GetComments, favorites use cases
 |
 |- presentation/
 |  |- component/          # Reusable UI components
 |  |- navigation/         # Bottom tab shell
 |  |- screen/             # Auth/Home/Favorites/PostDetail/Profile/Settings
 |  |- support/            # Environment helpers
 |  |- viewModel/          # HomeViewModel, PostDetailViewModel
```

## Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/hassaanjamil/SampleIOSPostsApp.git
   cd SampleIOSPostsApp
   ```
2. Start the local API (`http://127.0.0.1:3000`) using your preferred backend or JSON server.
3. Open `PostsApp.xcodeproj` in Xcode.
4. Select the `PostsApp` scheme and run on an iOS simulator.

### Requirements
- macOS with Xcode 16+
- iOS 17+ simulator or physical device
- Swift 5.9+

### Command Line Build & Test
```bash
xcodebuild \
  -project PostsApp.xcodeproj \
  -scheme PostsApp \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  clean test
```

## Local API Notes
- Endpoints used by this app:
  - `GET /posts`
  - `GET /users/:id`
  - `GET /comments/:postId`
- Need instant mock data? You can run JSON Server:
  ```bash
  npx json-server --watch db.json --port 3000
  ```

## Roadmap Ideas
- Add full unit tests for each layer and integration tests for view model flows.
- Replace mock auth gate with a real sign-in flow.
- Add offline-first caching for posts/comments.
- Add advanced filtering/sorting for posts and favorites.

## Contributing
Pull requests, issues, and ideas for improvements are welcome.

1. Star the repo.
2. Create a feature branch.
3. Add or update tests.
4. Run local checks.
5. Open a pull request.
