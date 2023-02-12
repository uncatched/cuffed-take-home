//
//  ImageCodable.swift
//  Cuffed
//
//  Created by Denys Litvinskyi on 11.02.2023.
//

import UIKit

struct ImageCodable: Codable {
    let image: UIImage

    enum CodingError: Error {
        case decodingFailed
        case encodingFailed
    }

    enum CodingKeys: String, CodingKey {
        case image
    }

    init(image: UIImage) {
        self.image = image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        guard let image = UIImage(data: data) else {
            throw CodingError.decodingFailed
        }

        self.image = image
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            throw CodingError.encodingFailed
        }

        try container.encode(data, forKey: CodingKeys.image)
    }
}
