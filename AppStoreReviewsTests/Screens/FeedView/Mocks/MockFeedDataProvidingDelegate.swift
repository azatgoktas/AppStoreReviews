//
//  MockFeedDataProvidingDelegate.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import XCTest

// Mock FeedDataProvidingDelegate to capture delegate method calls
class MockFeedDataProvidingDelegate: FeedDataProvidingDelegate {
    var fetchedReviews: [ReviewModel]?
    var fetchError: String?
    var expectation: XCTestExpectation?

    func didFetchFeedData(reviews: [ReviewModel]) {
        fetchedReviews = reviews
        expectation?.fulfill()
    }

    func fetchFeedDataDidFail(error: String) {
        fetchError = error
        expectation?.fulfill()
    }
}
