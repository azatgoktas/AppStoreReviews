//
//  FeedViewModelTests.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import XCTest


class FeedViewModelTests: XCTestCase {
    var sut: FeedViewModel!
    var mockDataProvider: MockFeedDataProviding!
    var mockRouter: MockFeedRouter!
    var mockView: MockFeedView!
    var mockDataProviderDelegate: MockFeedDataProvidingDelegate!

    override func setUp() {
        super.setUp()
        mockDataProviderDelegate = MockFeedDataProvidingDelegate()
        mockDataProvider = MockFeedDataProviding()
        mockRouter = MockFeedRouter()
        mockView = MockFeedView()
    }

    override func tearDown() {
        sut = nil
        mockDataProvider = nil
        mockRouter = nil
        mockView = nil
        super.tearDown()
    }

    func makeSUT() {
        sut = FeedViewModel(dataProvider: mockDataProvider, router: mockRouter)
        sut.delegate = mockView
        mockDataProvider.delegate = sut
    }

    func test_reviews_are_fetched_hides_loading_after_load_called() {
        // Given
        let review = ReviewModel(author: "Author", rating: "5", version: "1.0", title: "Title", content: "Great app content", id: "1")
        let expectation = XCTestExpectation(description: "Expecting Success")

        makeSUT()
        mockDataProvider.isSuccess = true
        mockDataProvider.reviews = [
            review
        ]
        mockView.expectation = expectation

        // When
        sut.load()

        // Then
        wait(for: [expectation], timeout: 1)
        let mappedReview = Review(author: "Author", version: "1.0", rating: 5, title: "Title", id: "1", content: "Great app content")
        XCTAssertEqual(self.mockView.receivedOutput[0], .showFeedData(presentation: FeedPresentation(reviews: [mappedReview])))
        XCTAssertTrue(mockRouter.isHideLoadingViewCalled)
    }

    func test_top_words_are_generated_after_load_called() {
        // Given
        let review = ReviewModel(author: "Author", rating: "5", version: "1.0", title: "Title", content: "Great app content", id: "1")
        let expectation = XCTestExpectation(description: "Expecting Success")

        makeSUT()
        mockDataProvider.isSuccess = true
        mockDataProvider.reviews = [
            review
        ]
        mockView.expectation = expectation

        // When
        sut.load()

        // Then
        wait(for: [expectation], timeout: 1)
        let mappedReview = Review(author: "Author", version: "1.0", rating: 5, title: "Title", id: "1", content: "Great app content")
        // less than 4 characters
        XCTAssertEqual(self.mockView.receivedOutput.last, .showTopWords(words: "great,content"))
    }

    func test_items_are_fetched_with_loading_after_SUT_calls_load() {
        // Given
        makeSUT()

        // When
        sut.load()

        // Then
        XCTAssert(mockRouter.isShowLoadingViewCalled)
        XCTAssertTrue(mockDataProvider.isFetchDataCalled)
    }

    func test_fetch_reviews_failed() {
        // Given
        let expectation = XCTestExpectation(description: "Expecting failure")
        makeSUT()
        mockDataProvider.isSuccess = false
        mockRouter.expectation = expectation

        // When
        sut.load()

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockRouter.isShowErrorCalled)
    }

    func test_tapping_review_navigates_to_detail() {
        // Given
        makeSUT()

        // When
        let review = Review(author: "Author", version: "1.0", rating: 5, title: "Title", id: "1", content: "Great app")
        sut.didTapReview(review)

        // Then
        XCTAssertEqual(mockRouter.navigateToItemDetailReview, review)
    }

    @MainActor
    func test_tapping_filter_filters_the_reviews() {
        // Given
        makeSUT()
        let filterResultReview = Review(author: "Author2", version: "1.0", rating: 2, title: "Title", id: "2", content: "Great app2")
        let reviews = [
            Review(author: "Author2", version: "1.0", rating: 5, title: "Title", id: "1", content: "Great app"),
            filterResultReview
            ]
        sut.allReviews = reviews

        // When
        sut.filterReviews(by: 2)

        // Then
        XCTAssertEqual(mockView.receivedOutput.first, .showFeedData(presentation: FeedPresentation(reviews: [filterResultReview])))
    }
}
