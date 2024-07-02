//
//  HTTPHeaderAdapter.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

/// An adapter to apply given headers for every request before it is executed
public final class HTTPHeaderAdapter: RequestAdapting {

    // MARK: Private

    private var headerProvidingClosure: () -> ([String: String])

    // MARK: Lifecycle

    public init(headerProvidingClosure: @escaping () -> ([String: String])) {
        self.headerProvidingClosure = headerProvidingClosure
    }

    // MARK: Public

    public func adapt(request: URLRequest) -> URLRequest {
        var mutableRequest = request
        let headers = headerProvidingClosure()
        headers.forEach {
            mutableRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        return mutableRequest
    }
}
