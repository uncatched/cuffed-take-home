//
//  ProfileViewModel.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    private let service: UserServiceProvider

    @Published private(set) var state: ProfileState = .loading
    @Published var isPresentingCreateNewUser = false

    init(service: UserServiceProvider = UserService()) {
        self.service = service

        Task {
            await load()
        }
    }

    func update(data: User.Data) {
        let newUser = User(data: data)
        self.state = .loaded(user: newUser)
        save(user: newUser)
    }

    func load() async {
        let loadedUser: User
        if let user = try? await service.load() {
            loadedUser = user
            self.state = .loaded(user: loadedUser)
            save(user: loadedUser)
        } else {
            self.state = .userNotFound
        }


    }

    func save(user: User) {
        Task {
            try await service.save(user: user)
        }
    }
}

extension ProfileViewModel {
    enum ProfileState: Equatable {
        static func == (lhs: ProfileViewModel.ProfileState, rhs: ProfileViewModel.ProfileState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.loaded(let lhsUser), .loaded(let rhsUser)):
                return lhsUser == rhsUser
            case (.userNotFound, .userNotFound):
                return true
            default:
                return false
            }
        }

        case loading
        case loaded(user: User)
        case userNotFound
    }
}
