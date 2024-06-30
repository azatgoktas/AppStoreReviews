//
//  NetworkURLRequestMaking.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

public protocol NetworkURLRequestMaking {
    func makeURLRequest<T: URLRequestable>(with requestable: T) throws -> URLRequest
}
