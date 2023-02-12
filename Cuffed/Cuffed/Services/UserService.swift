//
//  UserService.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import Foundation

protocol UserServiceProvider {
    func load() async throws -> User
    func save(user: User) async throws
}

final class UserService: UserServiceProvider {

    func load() async throws -> User {
        let task =  Task(priority: .background) {
            let url = try fileURL()
            let file = try FileHandle(forReadingFrom: url)
            let user = try JSONDecoder().decode(User.self, from: file.availableData)

            return user
        }

        let result = await task.result
        return try result.get()
    }

    func save(user: User) async throws {
        let task = Task(priority: .background) {
            let url = try fileURL()
            let data = try JSONEncoder().encode(user)
            try data.write(to: url)
        }

        let result = await task.result
        return try result.get()
    }

    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("user")
    }
}
