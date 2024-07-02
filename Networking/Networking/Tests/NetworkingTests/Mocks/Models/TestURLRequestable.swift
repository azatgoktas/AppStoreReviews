//
//  TestURLRequestable.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation
@testable import Networking

struct TestURLRequestable: URLRequestable {
    var baseURL: String
    var method: HTTPMethod
    var path: String
    var parameters: Encodable?
    var headers: [String: String]?
}
