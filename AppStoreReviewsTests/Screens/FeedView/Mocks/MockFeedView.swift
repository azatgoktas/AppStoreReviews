//
//  MockFeedView.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
@testable import AppStoreReviews
import XCTest

class MockFeedView: FeedViewModelDelegate {
    var receivedOutput: [FeedViewModelOutput] = []
    var expectation: XCTestExpectation?

    func handleViewModelOutput(_ output: FeedViewModelOutput) {
        receivedOutput.append(output)
        expectation?.fulfill()
    }
}
