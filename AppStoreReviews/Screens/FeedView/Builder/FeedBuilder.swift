//
//  FeedBuilder.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

final class FeedBuilder {
    static func make() -> FeedViewController {
        let viewController = FeedViewController()
        let feedDataProvider = FeedDataProvider(service: AppStoreService())
        let router = FeedRouter(viewController: viewController)
        let viewModel = FeedViewModel(
            dataProvider: feedDataProvider,
            router: router
        )
        feedDataProvider.delegate = viewModel
        viewController.viewModel = viewModel
        return viewController
    }
}
