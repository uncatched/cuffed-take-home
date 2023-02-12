//
//  Milestone.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import UIKit

struct Milestone: Identifiable, Codable {
    var id = UUID()

    let title: String
    let explanation: String
    let image: ImageCodable
}

extension Milestone {
    struct Data: Equatable {
        static func == (lhs: Milestone.Data, rhs: Milestone.Data) -> Bool {
            return lhs.title == rhs.title &&
            lhs.explanation == rhs.explanation &&
            lhs.image?.image == rhs.image?.image
        }

        var title: String = ""
        var explanation: String = ""
        var image: ImageCodable?
    }

    init(data: Milestone.Data) {
        self.title = data.title
        self.explanation = data.explanation
        self.image = data.image ?? .init(image: UIImage())
    }
}

extension Milestone {
    static var sample: Milestone {
        Milestone(
            title: "Graduated",
            explanation: "The best moment in my life. Met a lot of new friends here.",
            image: .init(image: UIImage(named: "sample_background")!))
    }
}
