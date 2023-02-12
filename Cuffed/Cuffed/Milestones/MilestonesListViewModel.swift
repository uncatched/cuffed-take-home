//
//  MilestonesListViewModel.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import Foundation

@MainActor
final class MilestonesListViewModel: ObservableObject {
    private let service: MilestoneServiceProvider

    @Published private(set) var milestones: [Milestone] = []

    init(service: MilestoneServiceProvider = MilestoneService()) {
        self.service = service

        Task {
            await load()
        }
    }

    func load() async {
        milestones = (try? await service.load()) ?? []
    }

    func add(data: Milestone.Data) {
        let newMilestone = Milestone(data: data)
        milestones.append(newMilestone)

        save(milestones: milestones)
    }

    func save(milestones: [Milestone]) {
        Task {
            try await service.save(milestones: milestones)
        }
    }
}
