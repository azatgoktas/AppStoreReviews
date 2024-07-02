//
//  SessionConfigurationProvider.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

enum SessionConfigurationProvider {
    static let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 5 // Waiting time for reconnection if internet is not available
        sessionConfiguration.shouldUseExtendedBackgroundIdleMode = true
        sessionConfiguration.timeoutIntervalForRequest = 60
        return sessionConfiguration
    }()
}
