//
//  LikesModel.swift
//  VKTest
//
//  Created by Андрей Бабкин on 08.10.2024.
//

import Foundation

// MARK: - Welcome
struct LikesStruct: Codable {
    let response: LikesResponse
}

// MARK: - Response
struct LikesResponse: Codable {
    let likes: Int
    let reactions: Reactions
}

// MARK: - Reactions
struct Reactions: Codable {
    let count: Int
}



