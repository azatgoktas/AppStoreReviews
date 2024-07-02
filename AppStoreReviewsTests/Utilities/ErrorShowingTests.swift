//
//  ErrorShowingTests.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import XCTest
@testable import AppStoreReviews

class ErrorShowingTests: XCTestCase {

    var mockRouter: MockRouter!
    var mockViewController: MockViewController!

    override func setUp() {
        super.setUp()
        mockViewController = MockViewController()
        mockRouter = MockRouter(viewController: mockViewController)
    }

    override func tearDown() {
        mockRouter = nil
        mockViewController = nil
        super.tearDown()
    }

    func test_show_error() {
        let errorMessage = "Test Error Message"
        mockRouter.showError(description: errorMessage)

        XCTAssertTrue(mockViewController.presentCalled, "Expected present to be called")

        guard let alert = mockViewController.viewControllerToBePresented as? UIAlertController else {
            XCTFail("Expected a UIAlertController to be presented")
            return
        }

        XCTAssertEqual(alert.title, "Something went wrong..")
        XCTAssertEqual(alert.message, errorMessage)
        XCTAssertEqual(alert.actions.first?.title, "OK")
    }
}
