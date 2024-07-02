//
//  TestURLRequestableFactory.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation
@testable import Networking

enum TestURLRequestableFactory {
    static func makeURLRequestable(
        httpMethod: HTTPMethod,
        parameters: TestModel?,
        headers: [String: String] = [:]
    ) -> TestURLRequestable {
        TestURLRequestable(
            baseURL: "https://itunes.apple.com",
            method: httpMethod,
            path: "test_resources",
            parameters: parameters,
            headers: headers
        )
    }
}
