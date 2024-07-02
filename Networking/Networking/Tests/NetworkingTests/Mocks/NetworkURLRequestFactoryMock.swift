//
//  NetworkURLRequestFactoryMock.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation
@testable import Networking

final class NetworkURLRequestFactoryMock: NetworkURLRequestMaking {
    var invokedMakeURLRequest = false
    var invokedMakeURLRequestCount = 0
    var invokedMakeURLRequestParameters: (requestable: Any, Void)?
    var invokedMakeURLRequestParametersList = [(requestable: Any, Void)]()
    var stubbedMakeURLRequestError: NetworkError?
    var stubbedMakeURLRequestResult = URLRequest(url: URL(string: "https://itunes.apple.com")!)

    func makeURLRequest<T: URLRequestable>(with requestable: T) throws -> URLRequest {
        invokedMakeURLRequest = true
        invokedMakeURLRequestCount += 1
        invokedMakeURLRequestParameters = (requestable, ())
        invokedMakeURLRequestParametersList.append((requestable, ()))
        if let error = stubbedMakeURLRequestError {
            throw error
        }
        return stubbedMakeURLRequestResult
    }
}
