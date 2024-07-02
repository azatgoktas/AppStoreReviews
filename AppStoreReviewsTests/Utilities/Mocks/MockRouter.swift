//
//  MockRouter.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import UIKit

class MockRouter: Router, ErrorShowing {
    var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
