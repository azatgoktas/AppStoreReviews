//
//  AppStoreFeedRequest.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 01/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import Networking

struct AppStoreFeedRequest: AppStoreRequest {
    var method: HTTPMethod = .get
    var path: String

    init(id: String) {
        path = "nl/rss/customerreviews/id=\(id)/sortby=mostrecent/json"
    }
}
