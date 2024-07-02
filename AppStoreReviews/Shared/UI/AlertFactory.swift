//
//  AlertFactory.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Typealiases

typealias AlertAction = (() -> Void)?

// MARK: - AlertFactory

/// Creates alert view controllers
enum AlertFactory {

    /// Creates error alert with specific title and OK action
    static func makeErrorAlert(
        message: String,
        okActionHandler: AlertAction = nil
    ) -> UIAlertController {
        let alertController = makeAlert(title: Constant.errorAlertTitle, message: message)
        let okAction = makeAction(title: Constant.okButtonTitle, action: okActionHandler)
        alertController.addAction(okAction)
        return alertController
    }
}

// MARK: - Helpers

extension AlertFactory {
    private static func makeAlert(title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    private static func makeAction(title: String, action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { _ in
            action?()
        }
    }
}

// MARK: - Constants

extension AlertFactory {
    private enum Constant {
        // can be localised
        static let errorAlertTitle = "Something went wrong.."
        static let okButtonTitle = "OK"
    }
}
