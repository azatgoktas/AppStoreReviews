//
//  AppStoreReviewTests.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import XCTest
@testable import AppStoreReviews
import Networking

final class AppStoreServiceTests: XCTestCase {

    var mockNetwork: MockNetworkProviding!
    var appStoreService: AppStoreService!

    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkProviding()
        appStoreService = AppStoreService(network: mockNetwork)
    }

    override func tearDown() {
        mockNetwork = nil
        appStoreService = nil
        super.tearDown()
    }

    func test_get_reviews_success() async {
        // Given
        let expectedReviews = [ReviewModel(author: "Author1", rating: "5", version: "1.0", title: "Great app", content: "Loved it", id: "123")]
        let reviewEntry = EntryResponse(
            author: AuthorResponse(name: LabelResponse(label: "Author1")),
            rating: LabelResponse(label: "5"),
            version: LabelResponse(label: "1.0"),
            title: LabelResponse(label: "Great app"),
            content: LabelResponse(label: "Loved it"),
            id: LabelResponse(label: "123")
        )
        let feed = FeedResponse(entry: [reviewEntry])
        let reviewResponse = ReviewResponse(feed: feed)
        mockNetwork.result = .success(reviewResponse)

        // When
        let result = await appStoreService.getReviews(id: "123")

        // Then
        switch result {
        case .success(let reviews):
            XCTAssertEqual(reviews, expectedReviews, "Reviews should match the expected reviews")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }

    func test_get_reviews_failure() async {
        // Given
        mockNetwork.result = .failure(.clientError(.generic))

        // When
        let result = await appStoreService.getReviews(id: "123")

        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, .clientError(.generic), "Error should be networkError")
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noHTTPResponse, .noHTTPResponse),
             (.parse, .parse),
             (.clientError, .clientError),
             (.serverError, .serverError),
             (.unknown, .unknown),
             (.invalidURL, .invalidURL),
             (.serialization, .serialization),
             (.requestTimedOut, .requestTimedOut),
             (.noInternetConnection, .noInternetConnection),
             (.executionError, .executionError):
            return true
        default:
            return false
        }
    }
}
