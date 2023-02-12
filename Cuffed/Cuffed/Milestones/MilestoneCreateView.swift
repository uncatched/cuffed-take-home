//
//  MilestoneCreateView.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI
import PhotosUI

struct MilestoneCreateView: View {
    @Binding var data: Milestone.Data
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            header
                .overlay(alignment: .center) {
                    PhotosPicker(selection: $selectedItem,
                                 matching: .images,
                                 photoLibrary: .shared(),
                                 label: { addBackgroundImage }
                    )
                    .buttonStyle(.borderless)
                }

            TextField("Title", text: $data.title)
                .padding(.top)
            Divider()

            explanation

            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        .onChange(of: selectedItem) { newValue in
            Task {
                let data = try? await newValue?.loadTransferable(type: Data.self)
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }

                self.data.image = ImageCodable(image: image)
            }
        }
    }

    private var explanation: some View {
        ZStack(alignment: .topLeading) {
            Text("Explanation...")
                .foregroundColor(Color(UIColor.placeholderText))
                .opacity(data.explanation.isEmpty ? 1 : 0)
                .padding(.top, 9)
                .padding(.leading, 3)
            TextEditor(text: $data.explanation)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
        }
    }

    private var addBackgroundImage: some View {
        Circle()
            .foregroundColor(Color.accentColor)
            .frame(width: 40, height: 40)
            .overlay {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.body.bold())
            }
    }

    private var header: some View {
        VStack {
            if let image = data.image?.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(20)
            } else {
                Color.gray
                    .frame(height: 240)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(20)
            }
        }
        .padding(.horizontal)
    }
}

struct MilestoneCreateView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneCreateView(data: .constant(Milestone.Data()))
    }
}
