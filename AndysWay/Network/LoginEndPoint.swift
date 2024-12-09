//
//  Login.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

struct LoginResponse: Decodable {
}

struct LoginEndPoint: ResourceEndPoint {
    typealias Response = LoginResponse
    
    static var path: String = "/login"
    
    static var availableHTTPMethods: [HTTPMethod] = [.POST]
}
