//
//  MockFeedRouter.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import XCTest

class MockFeedRouter: FeedViewRouting {
    var viewController: UIViewController?
    var loadingViewController: LoadingViewController = .init()
    var expectation: XCTestExpectation?

    private(set) var isShowErrorCalled = false
    func showError(description: String) {
        isShowErrorCalled = true
        expectation?.fulfill()
    }

    private(set) var isShowLoadingViewCalled = false
    func showLoadingView() {
        isShowLoadingViewCalled = true
        expectation?.fulfill()
    }

    private(set) var isHideLoadingViewCalled = false
    func hideLoadingView() {
        isHideLoadingViewCalled = true
        expectation?.fulfill()
    }

    private(set) var navigateToItemDetailReview: Review?
    func navigateToItemDetail(review: Review) {
        navigateToItemDetailReview = review
        expectation?.fulfill()
    }
}
