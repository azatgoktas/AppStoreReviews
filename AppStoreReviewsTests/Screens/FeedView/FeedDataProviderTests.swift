//
//  FeedDataProviderTests.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import XCTest

// Unit tests for FeedDataProvider
class FeedDataProviderTests: XCTestCase {
    var feedDataProvider: FeedDataProvider!
    var mockService: MockAppStoreService!
    var mockDelegate: MockFeedDataProvidingDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockAppStoreService()
        feedDataProvider = FeedDataProvider(service: mockService)
        mockDelegate = MockFeedDataProvidingDelegate()
        feedDataProvider.delegate = mockDelegate
    }

    override func tearDown() {
        feedDataProvider = nil
        mockService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func test_fetch_feed_fata_success() {
        // Given
        let expectedReviews = [
            ReviewModel(author: "test",
                        rating: "3",
                        version: "2.1",
                        title: "title",
                        content: "content",
                        id: "id")
        ]
        mockService.reviews = expectedReviews
        mockService.shouldReturnError = false
        let expectation = expectation(description: "Delegate receives success")

        mockDelegate.expectation = expectation

        // When
        feedDataProvider.fetchFeedData(appId: "123")

        // Then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.mockDelegate.fetchedReviews, expectedReviews, "Delegate should receive fetched reviews")
            XCTAssertNil(self.mockDelegate.fetchError, "Delegate should not receive an error")
        }
    }

    func test_fetch_feed_data_failure() {
        // Given
        mockService.shouldReturnError = true
        let expectation = expectation(description: "Delegate receives failure")

        mockDelegate.expectation = expectation

        // When
        self.feedDataProvider.fetchFeedData(appId: "123")

        // Then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(self.mockDelegate.fetchError, "Delegate should receive an error")
            XCTAssertNil(self.mockDelegate.fetchedReviews, "Delegate should not receive any reviews")
        }
    }
}

extension ReviewModel: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
