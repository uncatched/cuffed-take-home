//
//  MilestoneItemView.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import SwiftUI

struct MilestoneItemView: View {
    let milestone: Milestone

    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: milestone.image.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .overlay {
                        LinearGradient(
                            colors: [.black, .clear, .clear],
                            startPoint: .bottom, endPoint: .top
                        )
                    }
                    .cornerRadius(20)

                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(milestone.title)
                            .foregroundColor(.white)
                            .font(.callout.bold())

                        Text(milestone.explanation)
                            .foregroundColor(.white)
                            .font(.footnote)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
            }
        }
        .frame(height: 240)
        .padding(.vertical)
    }
}

struct MilestoneItemView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneItemView(milestone: .sample)
            .previewLayout(.fixed(width: 450, height: 300))
    }
}
