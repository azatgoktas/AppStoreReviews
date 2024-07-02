//
//  FeedViewModel.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

final class FeedViewModel: FeedViewModelProtocol {

    // MARK: - Internal
    weak var delegate: FeedViewModelDelegate?
    var allReviews: [Review] = []

    // MARK: - Internal
    private let dataProvider: FeedDataProviding
    private let router: FeedViewRouting

    private enum Constants {
        static let letterCountLimit = 4
        static let topCommentCount = 3
        static let appId = "474495017"
    }

    init(
        dataProvider: FeedDataProviding,
        router: FeedViewRouting
    ) {
        self.dataProvider = dataProvider
        self.router = router
    }

    func load() {
        router.showLoadingView()
        fetchFeedData()
    }

    func fetchFeedData() {
        dataProvider.fetchFeedData(appId: Constants.appId)
    }

    func didTapReview(_ review: Review) {
        router.navigateToItemDetail(review: review)
    }

    @MainActor
    func filterReviews(by stars: Int) {
        let filteredReviews: [Review]
        if stars == 0 {
            filteredReviews = allReviews
        } else {
            filteredReviews = allReviews.filter { $0.rating == stars }
        }
        let presentation = FeedPresentation(reviews: filteredReviews)
        delegate?.handleViewModelOutput(.showFeedData(presentation: presentation))
        updateTopWords(for: presentation.reviews)
    }

    private func mapToPresentation(feedData: [ReviewModel]) -> FeedPresentation {
        let reviews = feedData.map { review in
            Review(
                author: review.author,
                version: review.version,
                rating: Int(review.rating) ?? 0,
                title: review.title,
                id: review.id,
                content: review.content
            )
        }
        return FeedPresentation(reviews: reviews)
    }

    @MainActor
    private func updateTopWords(for reviews: [Review]) {
        let topWords = calculateTopWords(in: reviews)
        delegate?.handleViewModelOutput(.showTopWords(words: topWords.joined(separator: ",")))
    }

    private func calculateTopWords(in reviews: [Review]) -> [String] {
        var wordCounts: [String: Int] = [:]

        for review in reviews {
            let words = review.content
                .lowercased()
                .split { !$0.isLetter }
                .map(String.init)
                .filter { $0.count >= Constants.letterCountLimit }

            for word in words {
                wordCounts[word, default: 0] += 1
            }
        }

        let sortedWords = wordCounts.sorted { $0.value > $1.value }
        let topWords = sortedWords.prefix(Constants.topCommentCount).map { $0.key }
        return topWords
    }
}

extension FeedViewModel: FeedDataProvidingDelegate {
    @MainActor
    func didFetchFeedData(reviews: [ReviewModel]) {
        let presentation = mapToPresentation(feedData: reviews)
        self.allReviews = presentation.reviews
        delegate?.handleViewModelOutput(.showFeedData(presentation: presentation))
        router.hideLoadingView()
        updateTopWords(for: presentation.reviews)
    }

    @MainActor
    func fetchFeedDataDidFail(error: String) {
        router.showError(description: error)
        router.hideLoadingView()
    }
}
