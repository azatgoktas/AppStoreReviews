//
//  HTTPMethod.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

public enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
