//
//  MockNetworkProviding.swift
//  AppStoreReviewsTests
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

@testable import AppStoreReviews
import Foundation
import Networking

class MockNetworkProviding: NetworkProviding {
    var result: Result<ReviewResponse, NetworkError>?

    func request<T, V>(requestable: V, responseType: T.Type) async -> Result<T, NetworkError> where T : Decodable, V : URLRequestable {
        guard let result = result as? Result<T, NetworkError> else {
            return .failure(.noHTTPResponse(.generic))
        }
        return result
    }
}
