//
//  AppStoreService.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 30/06/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import Networking

protocol StoreServing {
    func getReviews(id: String) async -> Result<[ReviewModel], NetworkError>
}

class AppStoreService: StoreServing {
    // MARK: - Private
    private let network: NetworkProviding

    init(network: NetworkProviding = Networking()) {
        self.network = network
    }

    func getReviews(id: String) async -> Result<[ReviewModel], NetworkError> {
        let requestable = AppStoreFeedRequest(id: id)

        let result = await network.request(requestable: requestable, responseType: ReviewResponse.self)
        switch result {
        case .success(let response):
            let entries = response.feed.entry.map { entry in
                ReviewModel(
                    author: entry.author.name.label,
                    rating: entry.rating.label,
                    version: entry.version.label,
                    title: entry.title.label,
                    content: entry.content.label,
                    id: entry.id.label
                )
            }

            return .success(entries)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
