//
//  ProfileUserView.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI

struct ProfileUserView: View {
    let user: User
    let save: (User.Data) -> Void

    @State private var isPresentingEditProfile = false
    @State private var data = User.Data()

    var body: some View {
        return content
            .sheet(isPresented: $isPresentingEditProfile) {
                editProfile
            }
    }

    private var content: some View {
        VStack(alignment: .leading) {
            header
        }
        .padding(.top)
    }

    private var header: some View {
        HStack {
            ProfileImage(image: user.profileImage?.image)
                .padding(.trailing)
                .padding(.leading, 16)
            profileInfo
            Spacer()
        }
    }

    private var profileInfo: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.title3.bold())

            if let age = user.age {
                Text(age)
                    .font(.body)
            }

            Text(user.about)
                .font(.body)
                .padding(.top, 1)

            HStack {
                Button {
                    isPresentingEditProfile = true
                    data = user.data
                } label: {
                    Text("Edit Profile")
                        .padding(8)
                        .foregroundColor(.white)
                }
            }
            .background(Color.accentColor)
            .cornerRadius(8)
        }
    }

    private var editProfile: some View {
        NavigationView {
            EditProfileView(data: $data)
                .navigationTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditProfile = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingEditProfile = false
                            save(data)
                        }
                    }
                }
        }
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUserView(user: User.sample) { _ in }
    }
}
