//
//  ErrorShowing.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation

protocol ErrorShowing {
    func showError(description: String)
}

// MARK: - Router + Default implementation

extension ErrorShowing where Self: Router {
    func showError(description: String) {
        let errorAlertViewController = AlertFactory.makeErrorAlert(message: description)
        viewController?.present(errorAlertViewController, animated: true)
    }
}
