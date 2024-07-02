//
//  FeedResponse.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

struct FeedResponse: Decodable {
    let entry: [EntryResponse]
}

struct ReviewResponse: Decodable {
    let feed: FeedResponse
}

struct EntryResponse: Decodable {
    let author: AuthorResponse
    let rating: LabelResponse
    let version: LabelResponse
    let title: LabelResponse
    let content: LabelResponse
    let id: LabelResponse

    enum CodingKeys: String, CodingKey {
        case author
        case rating = "im:rating"
        case version = "im:version"
        case title
        case content
        case id
    }
}
struct ReviewModel {
    let author: String
    let rating: String
    let version: String
    let title: String
    let content: String
    let id: String
}


struct AuthorResponse: Decodable {
    let name: LabelResponse
}

struct LabelResponse: Decodable {
    let label: String
}
