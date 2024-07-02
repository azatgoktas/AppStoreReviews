//
//  FeedContracts.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

struct FeedPresentation: Equatable {
    let reviews: [Review]
}

protocol FeedViewModelProtocol {
    var delegate: FeedViewModelDelegate? { get set }
    func load()
    func fetchFeedData()
    func filterReviews(by stars: Int)
    func didTapReview(_ review: Review)
}

enum FeedViewModelOutput: Equatable {
    case showFeedData(presentation: FeedPresentation)
    case showTopWords(words: String)
}

protocol FeedViewModelDelegate: AnyObject {
    @MainActor
    func handleViewModelOutput(_ output: FeedViewModelOutput)
}

protocol FeedViewRouting: AnyObject, Router, ErrorShowing, LoadingViewShowing {
    func navigateToItemDetail(review: Review)
}
