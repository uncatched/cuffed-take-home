//
//  EditProfileView.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Binding var data: User.Data

    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        VStack {
            profileImage
            profileInfo
            Spacer()
        }
        .padding()
    }

    private var profileImage: some View {
        ProfileImage(image: data.profileImage?.image)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $selectedItem,
                             matching: .images,
                             photoLibrary: .shared(),
                             label: { editProfileImageIcon }
                )
                .buttonStyle(.borderless)
            }
            .onChange(of: selectedItem) { newValue in
                Task {
                    let data = try? await newValue?.loadTransferable(type: Data.self)
                    guard let data = data, let image = UIImage(data: data) else {
                        return
                    }

                    self.data.profileImage = ImageCodable(image: image)
                }
            }
    }

    private var editProfileImageIcon: some View {
        Image(systemName: "pencil.circle.fill")
            .symbolRenderingMode(.multicolor)
            .font(.largeTitle)
            .foregroundColor(.accentColor)
    }

    private var profileInfo: some View {
        HStack {
            VStack(alignment: .leading) {
                TextField("Name", text: $data.name)
                Divider()

                DatePicker(selection: $data.birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Birth Date")
                }
                Divider()

                about
            }
        }
        .padding(.top)
    }

    private var about: some View {
        ZStack(alignment: .topLeading) {
            Text("About you...")
                .foregroundColor(Color(UIColor.placeholderText))
                .opacity(data.about.isEmpty ? 1 : 0)
                .padding(.top, 9)
                .padding(.leading, 3)
            TextEditor(text: $data.about)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(data: .constant(User.sample.data))
    }
}
