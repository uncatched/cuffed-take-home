//
//  ProfileView.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.scenePhase) private var scenePhase

    @StateObject private var viewModel = ProfileViewModel()

    @State private var newUserData = User.Data()
    @State private var isPresentingNewUserCreate = false

    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .userNotFound:
            ProgressView()
            .onAppear {
                newUserData = User.Data()

                Task { @MainActor in
                    isPresentingNewUserCreate = true
                }
            }
            .sheet(isPresented: $isPresentingNewUserCreate) {
                NavigationView {
                    EditProfileView(data: $newUserData)
                        .navigationTitle("Edit Profile")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingNewUserCreate = false
                                    viewModel.update(data: newUserData)
                                }
                                .disabled(newUserData.name.isEmpty || newUserData.profileImage == nil)
                            }
                        }
                }
            }
        case .loaded(let user):
            ScrollView {
                VStack {
                    ProfileUserView(user: user) { data in
                        viewModel.update(data: data)
                    }

                    MilestoneListView()

                    Spacer()
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.never)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
