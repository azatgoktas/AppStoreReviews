//
//  RequestAdapting.swift
//  
//
//  Created by Azat Goktas on 30/06/2024.
//

import Foundation

public protocol RequestAdapting: AnyObject {
    func adapt(request: URLRequest) -> URLRequest
}
