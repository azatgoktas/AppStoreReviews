//
//  LoadingViewShowing.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

protocol LoadingViewShowing {
    var loadingViewController: LoadingViewController { get }
    func showLoadingView()
    func hideLoadingView()
}

// MARK: - Router + Default implementation

extension LoadingViewShowing where Self: Router {
    func showLoadingView() {
        guard loadingViewController.presentingViewController == nil else { return }
        viewController?.navigationController?.present(loadingViewController, animated: false)
    }

    func hideLoadingView() {
        loadingViewController.dismiss(animated: false)
    }
}
