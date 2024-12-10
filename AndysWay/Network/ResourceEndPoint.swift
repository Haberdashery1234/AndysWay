//
//  ResourceEndPoint.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

//Create a protocol representing a REST end point and all possible functions

enum HTTPMethod: String {
    case GET, POST, PUT
}

protocol ResourceEndPoint {
    static var path: String { get }
    static var availableHTTPMethods: [HTTPMethod] { get }
}

extension ResourceEndPoint {

}
