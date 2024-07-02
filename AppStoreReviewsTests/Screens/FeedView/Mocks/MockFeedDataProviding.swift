//
//  MockFeedDataProviding.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation

class MockFeedDataProviding: FeedDataProviding {
    var delegate: FeedDataProvidingDelegate?
    private(set) var isFetchDataCalled = false
    var isSuccess = false
    var reviews: [ReviewModel] = []

    func fetchFeedData(appId: String) {
        isFetchDataCalled = true
        if isSuccess {
            delegate?.didFetchFeedData(reviews: reviews)
        } else {
            delegate?.fetchFeedDataDidFail(error: "error")
        }
    }
}
