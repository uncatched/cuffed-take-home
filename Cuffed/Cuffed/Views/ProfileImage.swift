//
//  ProfileImage.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI

struct ProfileImage: View {
    let image: UIImage?

    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())

            } else {
                Circle()
                    .frame(width: 120, height: 120)
            }
        }
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(image: UIImage(named: "sample_profile"))
    }
}
