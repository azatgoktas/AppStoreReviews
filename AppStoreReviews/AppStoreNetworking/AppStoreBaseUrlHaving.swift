//
//  AppStoreBaseUrlHaving.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 30/06/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import Networking

protocol AppStoreBaseUrlHaving: BaseURLHaving { }

// MARK: - Default implementation

extension AppStoreBaseUrlHaving {
    var baseURL: String {
        "https://itunes.apple.com/"
    }
}
