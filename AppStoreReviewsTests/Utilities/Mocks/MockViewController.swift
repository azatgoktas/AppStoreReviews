//
//  MockViewController.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import UIKit

class MockViewController: UIViewController {
    var viewControllerToBePresented: UIViewController?
    var presentCalled = false

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToBePresented = viewControllerToPresent
        presentCalled = true
        completion?()
    }
}
