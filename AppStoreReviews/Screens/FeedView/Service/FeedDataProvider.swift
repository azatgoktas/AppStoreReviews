//
//  FeedDataProvider.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

protocol FeedDataProviding {
    var delegate: FeedDataProvidingDelegate? { get set }
    func fetchFeedData(appId: String)
}

protocol FeedDataProvidingDelegate: AnyObject {
    func didFetchFeedData(reviews: [ReviewModel])
    func fetchFeedDataDidFail(error: String)
}

final class FeedDataProvider: FeedDataProviding {
    weak var delegate: FeedDataProvidingDelegate?

    private let service: StoreServing

    init(service: StoreServing) {
        self.service = service
    }

    func fetchFeedData(appId: String) {
        Task {
            let result = await self.service.getReviews(id: appId)
            switch result {
            case .success(let feedData):
                await MainActor.run {
                    self.delegate?.didFetchFeedData(reviews: feedData)
                }
            case .failure(let error):
                await MainActor.run {
                    self.delegate?.fetchFeedDataDidFail(error: error.localizedDescription)
                }
            }
        }
    }
}
