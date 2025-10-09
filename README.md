# PostsApp (iOS)

A SwiftUI (100% Swift) sample project that mirrors the [Android Posts App](https://github.com/hassaanjamil/android-posts-app) and consume [npm-rest-api](https://github.com/hassaanjamil/npm-sample-posts-rest-api). It demonstrates how to consume a posts API and render a home feed while following Clean Architecture guidelines for iOS.

  > For this app, please have a look at my open source [Posts Rest API respository](https://github.com/hassaanjamil/node-posts-rest-api):
Configure it, by following the instructions and run the local server to make this android app works for you, and check if you are running your server using the same port number (3000) or not.

## 📱 Features
- Authenticate mock user and land on a tab-based shell.
- Fetch posts asynchronously from `http://127.0.0.1:3000/posts`, my [posts-rest-api](https://github.com/hassaanjamil/node-posts-rest-api) repository (local server) .
- Display Posts items within a lazily rendered list.
- Navigate to a post detail screen for each post.
- Pull-to-refresh support and basic error handling UI.

## 🏗 Architecture
The project mirrors the layered setup following clean architecture guidelines:

- **presentation** – SwiftUI screens (`HomeView`, `AuthView`, etc.), view models (`HomeViewModel`), and reusable components.
- **domain** – Business rules expressed as pure Swift entities (`PostDto`), repository contracts, and use cases (`GetPostsUseCase`).
- **data** – Remote implementations using `NetworkManager`, repository adapters (`PostRepository`), protocol definitions, and lightweight data mappers (`PostMapper`).

Dependencies are wired at the edges through Swinject so presentation never constructs concrete data layer types directly. Each layer remains testable in isolation by relying on protocols.

## 🧩 Tech Stack
- **SwiftUI** for the UI layer and navigation.
- **Combine-lite** state model using `ObservableObject` / `@StateObject`.
- **Swift concurrency** (`async`/`await`) for networking and repository calls.
- **Swinject** for dependency injection across layers.
- **SPM-first** dependency management.

## 🧬 Dependency Injection
`AppContainer` bootstraps a `Swinject.Container`, registers protocols for the network, repository, use case, mapper, and view model layers, then exposes the container to SwiftUI through a custom environment key. Screens resolve the dependencies they need rather than instantiating concrete types, keeping the architecture clean and test-friendly. Swap the registrations or inject mock implementations in tests to exercise flows without touching production services.

## 🗂 Module & Folder Layout
```
PostsApp
├── data
│   ├── di
│   │   └── AppContainer.swift
│   ├── network
│   │   ├── NetworkManager.swift
│   │   └── NetworkManagerProtocol.swift
│   ├── repository
│   │   └── PostRepository.swift
│   ├── mapper
│   │   └── PostMapper.swift
│   └── protocol
│       └── PostMapperProtocol.swift
├── domain
│   ├── entities
│   │   └── PostDto.swift
│   ├── repository
│   │   └── PostRepositoryProtocol.swift
│   └── usecase
│       └── GetPostsUseCase.swift
└── presentation
    ├── component
    │   ├── CardView.swift
    │   └── ErrorView.swift
    ├── navigation
    │   └── BottomBarContentView.swift
    ├── screen
    │   ├── AuthView.swift
    │   ├── HomeView.swift
    │   ├── PostDetailView.swift
    │   ├── FavoriteView.swift
    │   ├── ProfileView.swift
    │   └── SettingsView.swift
    ├── support
    │   └── AppContainer+Environment.swift
    └── viewModel
        └── HomeViewModel.swift
```

## 🚀 Getting Started
### Requirements
- Xcode 16.x (see CI configuration)
- iOS 17+ simulator or device
- Swift 5.9+

### Run the App
1. Clone the repository.
2. Open `PostsApp.xcodeproj` (no workspace required).
3. Select the `PostsApp` scheme and hit **Run** (⌘R).

### Command Line Build & Test
```
xcodebuild \
  -project PostsApp.xcodeproj \
  -scheme PostsApp \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  clean test
```

## 🔄 Continuous Integration
The `.github/workflows/ci.yml` pipeline runs on `macos-14`, selects Xcode 16, and executes `xcodebuild clean test` on the iOS simulator to keep parity with local builds.

## 🧪 Testing & Improvements
- Unit/UI tests are not yet implemented. Add them per layer (e.g., mock `PostRepositoryProtocol` for domain tests).
- Expand `PostDetailView` to show complete post information.
- Swap the mock authentication toggle with a real auth flow if needed.

## 🤝 Contributing
1. ⭐️ Star the repo to support continued development.
2. Create a feature branch.
3. Add or update tests where applicable.
4. Run the CI command locally.
5. Submit a pull request.

## 📄 License
MIT License. See `LICENSE` if included, otherwise adapt as needed.
