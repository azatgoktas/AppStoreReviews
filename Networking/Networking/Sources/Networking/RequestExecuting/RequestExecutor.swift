//
//  RequestExecutor.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

final class RequestExecutor: RequestExecuting {

    // MARK: Lifecycle

    init(
        session: URLSession
    ) {
        self.session = session
    }

    // MARK: Internal

    var session: URLSession

    // MARK: - RequestExecuting

    func execute(_ request: URLRequest) async -> Result<RequestSuccessModel, Error> {
        do {
            let (data, response) = try await session.data(for: request)
            return .success(RequestSuccessModel(data: data, response: response))
        } catch let error {
            return .failure(error)
        }
    }
}
