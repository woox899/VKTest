//
//  NewsFeedModel.swift
//  VKTest
//
//  Created by Андрей Бабкин on 27.09.2024.
//

import Foundation

struct Welcome: Codable {
    let response: Response
}

struct Response: Codable {
    let items: [ResponseItem]
    let profiles: [Profile]
    let groups: [Group]
}

struct Group: Codable {
    let id: Int?
    let name: String?
    let photo200: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo200 = "photo_200"
    }
}

struct ResponseItem: Codable {
    let attachments: [Attachment]
    let date: Int?
    var likes: Likes
    let ownerID: Int
    let text: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case attachments
        case likes
        case date
        case ownerID = "owner_id"
        case text
        case id
    }
}

struct Attachment: Codable {
    let type: String
    let photo: Photo?
}

struct Link: Codable {
    let url: String?
    let photo: Photo?
}

struct Photo: Codable {
    let id: Int
    let ownerID: Int
    let accessKey: String?
    let sizes: [OrigPhoto]?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case sizes
    }
}

struct OrigPhoto: Codable {
    let url: String?
}

struct Likes: Codable {
    var count: Int
}

struct Profile: Codable {
    let id: Int?
    let photo100: String?
    let firstName: String?
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}



