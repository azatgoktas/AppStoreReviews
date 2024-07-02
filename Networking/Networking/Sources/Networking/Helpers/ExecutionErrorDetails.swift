//
//  ExecutionErrorDetails.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

public struct ExecutionErrorDetails {
    public static var generic: Self {
        .init(
            message: "Something went wrong.",
            code: 0,
            errorDescription: nil
        )
    }

    public let message: String?
    public let code: Int
    public let errorDescription: String?
}

// MARK: CustomStringConvertible

extension ExecutionErrorDetails: CustomStringConvertible {
    public var description: String {
        """
        \(Self.self):
        {
            message: \(message ?? ""),
            code: \(code),
            errorDescription: \(errorDescription ?? "")
        }
        """
    }
}
