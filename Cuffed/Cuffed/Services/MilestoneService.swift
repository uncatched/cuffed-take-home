//
//  MilestoneService.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import Foundation

protocol MilestoneServiceProvider {
    func load() async throws -> [Milestone]
    func save(milestones: [Milestone]) async throws
}

final class MilestoneService: MilestoneServiceProvider {

    func load() async throws -> [Milestone] {
        let task =  Task(priority: .background) {
            let url = try fileURL()
            let file = try FileHandle(forReadingFrom: url)
            let user = try JSONDecoder().decode([Milestone].self, from: file.availableData)

            return user
        }

        let result = await task.result
        return try result.get()
    }

    func save(milestones: [Milestone]) async throws {
        let task = Task(priority: .background) {
            let url = try fileURL()
            let data = try JSONEncoder().encode(milestones)
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
            .appendingPathComponent("milestones")
    }
}
