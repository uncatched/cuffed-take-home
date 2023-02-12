//
//  MilestoneListView.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI

struct MilestoneListView: View {
    @StateObject private var viewModel = MilestonesListViewModel()

    @State private var data = Milestone.Data()
    @State private var isPresentingAddMilestone = false
    @State private var isAllowedToCreateNewMilestone = false

    var body: some View {
        VStack {
            milestonesHeader
            milestonesList
            Spacer()
        }
        .sheet(isPresented: $isPresentingAddMilestone) {
            addMilestone
        }
    }

    private var milestonesHeader: some View {
        HStack {
            Text("Milestones")
                .font(.title2.bold())
            Spacer()
            Button {
                isPresentingAddMilestone = true
                data = Milestone.Data()
            } label: {
                Circle()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.body.bold())
                    }
            }
        }
    }

    private var milestonesList: some View {
        LazyVStack {
            ForEach(viewModel.milestones) { milestone in
                MilestoneItemView(milestone: milestone)
            }
        }
    }

    private var addMilestone: some View {
        NavigationView {
            MilestoneCreateView(data: $data)
                .navigationTitle("Add Milestone")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingAddMilestone = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingAddMilestone = false
                            viewModel.add(data: data)
                        }
                        .disabled(data.title.isEmpty || data.explanation.isEmpty || data.image == nil)
                    }
                }
        }
    }
}

struct MilestoneListView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneListView()
    }
}
