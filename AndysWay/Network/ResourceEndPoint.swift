//
//  ResourceEndPoint.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

protocol ResourceEndPoint {
    // Path of end point
    var path: String { get }
    
    func GET()
    func POST()
    func PUT()
    func DELETE()
}

extension ResourceEndPoint {
    func GET() {
        
    }
    
    func POST() {
        
    }
    
    func PUT() {
        
    }
    
    func DELETE() {
        
    }
}
