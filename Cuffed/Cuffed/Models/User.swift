//
//  User.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import UIKit

struct User: Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
        lhs.birthDate == rhs.birthDate &&
        lhs.about == rhs.about &&
        lhs.profileImage?.image == rhs.profileImage?.image
    }

    let name: String
    let birthDate: Date?
    let about: String
    let profileImage: ImageCodable?

    var age: String? {
        guard let birthDate = birthDate else { return nil }
        let components = Calendar.current.dateComponents([.year], from: birthDate, to: Date())
        guard let years = components.year, years > 0 else { return nil }

        return "\(years) y.o."
    }
}

extension User {
    struct Data {
        var name: String = ""
        var birthDate: Date = Date()
        var about: String = ""
        var profileImage: ImageCodable?
    }

    var data: User.Data {
        User.Data(name: name, birthDate: birthDate ?? Date(), about: about, profileImage: profileImage)
    }

    init(data: User.Data) {
        self.name = data.name
        self.birthDate = data.birthDate
        self.about = data.about
        self.profileImage = data.profileImage
    }

    mutating func update(from data: User.Data) {
        self = User(data: data)
    }
}

extension User {
    static var sample: User {
        User(
            name: "John Appleseed",
            birthDate: Date(timeIntervalSinceReferenceDate: 0),
            about: "Live laugh love",
            profileImage: .init(image: UIImage(named: "sample_profile")!)
        )
    }
}
