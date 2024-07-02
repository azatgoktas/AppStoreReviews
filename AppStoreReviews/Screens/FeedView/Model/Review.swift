//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

struct Review {
    let author: String
    let version: String
    let rating: Int
    let title: String
    let id: String
    let content: String
    
    func ratingVersionText() -> String {
        var stars = ""
        for _ in 0..<rating {
            stars += "⭐️"
        }
        return "\(stars) (ver: \(version))"
    }
}

extension Review: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Review: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}