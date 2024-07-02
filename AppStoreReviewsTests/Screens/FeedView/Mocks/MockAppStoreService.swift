//
//  MockAppStoreService.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import Networking

class MockAppStoreService: StoreServing {
    var shouldReturnError = false
    var reviews: [ReviewModel] = []

    func getReviews(id: String) async -> Result<[ReviewModel], NetworkError> {
        if shouldReturnError {
            return .failure(.noInternetConnection(.generic))
        } else {
            return .success(reviews)
        }
    }
}
