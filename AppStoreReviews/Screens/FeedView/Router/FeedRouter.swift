//
//  FeedRouter.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import UIKit

final class FeedRouter {

    // MARK: - Internal variables

    private(set) weak var viewController: UIViewController?
    let loadingViewController = LoadingViewController()

    // MARK: - Initialisers

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - MuseumItemsListRouting

extension FeedRouter: FeedViewRouting {
    func navigateToItemDetail(review: Review) {
        let nextViewController = DetailsViewController(review: review)
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
